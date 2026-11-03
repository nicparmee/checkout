import 'dart:convert';

import 'package:checkout/app/app.dart';
import 'package:checkout/app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<App> _app() async {
  SharedPreferences.setMockInitialValues({});
  return App(prefs: await SharedPreferences.getInstance());
}

Future<void> _pickCard(WidgetTester tester, String label) async {
  await tester.tap(find.byType(DropdownButtonFormField<String>));
  await tester.pump(const Duration(seconds: 1));
  await tester.tap(find.text(label).last);
  await tester.pump(const Duration(seconds: 1));
}

void main() {
  testWidgets('deeplinks resolve and unknown paths fall back to catalog', (
    tester,
  ) async {
    await tester.pumpWidget(await _app());
    expect(find.text('Catalog'), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.text('Classic Tee'), findsOneWidget);

    router.go('/order/42');
    await tester.pumpAndSettle();
    expect(find.text('Order 42'), findsOneWidget);
    expect(find.text('Order not found'), findsOneWidget);

    router.go('/nope');
    await tester.pumpAndSettle();
    expect(find.text('Catalog'), findsOneWidget);
  });

  testWidgets('placing an order requires signing in first', (tester) async {
    await tester.pumpWidget(await _app());
    router.go('/catalog');
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add').first);
    await tester.pump();
    await tester.tap(find.byTooltip('Cart (1 items)'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Sign in to order'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();

    // Back on the summary, now allowed to order.
    expect(find.text('Place order'), findsOneWidget);
    // Persisted, so a fresh app start (refresh) stays signed in.
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('userId'), 'user-1');
  });

  testWidgets('place an order with a slot, then pay with a saved card', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({'userId': 'user-1'});
    await tester.pumpWidget(App(prefs: await SharedPreferences.getInstance()));
    router.go('/catalog');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add').first);
    router.go('/summary');
    await tester.pumpAndSettle();

    FilledButton button() => tester.widget(find.byType(FilledButton));
    expect(button().onPressed, isNull, reason: 'no slot picked yet');
    await tester.tap(find.text('10:00 AM'));
    await tester.pump();
    await tester.tap(find.text('2:00 PM'));
    await tester.pump();
    expect(
      tester
          .widgetList<ChoiceChip>(find.byType(ChoiceChip))
          .where((c) => c.selected),
      hasLength(1),
    );

    await tester.tap(find.text('Place order'));
    // The order page ticks every second, so pump instead of pumpAndSettle.
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 1));
    expect(find.textContaining('Expires in'), findsOneWidget);
    expect(button().onPressed, isNull, reason: 'no card picked yet');

    Future<void> payAndWait() async {
      await tester.tap(find.textContaining('Pay \$25.00'));
      await tester.pump();
      // Card details are swapped for a processing view during the delay.
      expect(find.text('Processing payment…'), findsOneWidget);
      expect(find.byType(DropdownButtonFormField<String>), findsNothing);
      await tester.pump(const Duration(seconds: 2));
      await tester.pump();
    }

    await _pickCard(tester, 'Mastercard •••• 0002 (declines)');
    await payAndWait();
    expect(find.text('Payment declined. Try another card.'), findsOneWidget);

    await _pickCard(tester, 'Visa •••• 4242');
    await payAndWait();
    expect(find.text('Payment successful'), findsOneWidget);

    // Cart was cleared when the order was created.
    router.go('/summary');
    await tester.pumpAndSettle();
    expect(find.text('Your cart is empty'), findsOneWidget);
  });

  testWidgets('refreshing mid-payment shows processing, never Pay again', (
    tester,
  ) async {
    final now = DateTime.now().toUtc();
    SharedPreferences.setMockInitialValues({
      'userId': 'user-1',
      'order:1': jsonEncode({
        'id': '1',
        'userId': 'user-1',
        'items': [
          {'productId': '1', 'quantity': 1},
        ],
        'scheduledAt': now.add(const Duration(days: 1)).toIso8601String(),
        'expiresAt': now.add(const Duration(minutes: 2)).toIso8601String(),
        'status': 'PENDING',
        'totalCents': 2500,
      }),
    });
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(App(prefs: prefs));
    router.go('/order/1');
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();

    await _pickCard(tester, 'Visa •••• 4242');
    await tester.tap(find.textContaining('Pay \$25.00'));
    await tester.pump();
    expect(prefs.getString('order:1'), contains('"PROCESSING"'));

    // Refresh: tear the app down and boot it again on the same URL.
    await tester.pumpWidget(const SizedBox());
    await tester.pumpWidget(App(prefs: prefs));
    router.go('/order/1');
    await tester.pump();
    await tester.pump();
    expect(find.text('Processing payment…'), findsOneWidget);
    expect(find.byType(FilledButton), findsNothing);

    // The backend finishes the payment; the page polls and picks it up.
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(seconds: 1));
    await tester.pump();
    expect(find.text('Payment successful'), findsOneWidget);
  });
}

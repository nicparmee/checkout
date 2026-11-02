import 'package:checkout/app/app.dart';
import 'package:checkout/app/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<App> _app() async {
  SharedPreferences.setMockInitialValues({});
  return App(prefs: await SharedPreferences.getInstance());
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
    expect(prefs.getBool('signedIn'), isTrue);
  });
}

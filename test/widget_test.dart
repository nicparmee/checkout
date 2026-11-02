import 'package:checkout/app/app.dart';
import 'package:checkout/app/router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('deeplinks resolve and unknown paths fall back to catalog', (
    tester,
  ) async {
    await tester.pumpWidget(const App());
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
}

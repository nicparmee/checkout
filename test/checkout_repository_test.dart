import 'dart:async';

import 'package:checkout/features/checkout/data/datasources/checkout_remote_data_source.dart';
import 'package:checkout/features/checkout/data/repositories/checkout_repository_impl.dart';
import 'package:checkout/features/checkout/domain/entities/order.dart';
import 'package:checkout/graphql/local_link.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('orders are priced, persisted, paid, declined and expire', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    var clock = DateTime(2026, 1, 1, 12);
    // A fresh link per call stands in for an app restart reading prefs.
    CheckoutRepositoryImpl repo() => CheckoutRepositoryImpl(
      CheckoutRemoteDataSource(
        GraphQLClient(
          link: LocalLink(prefs, now: () => clock, paymentDelay: Duration.zero),
          cache: GraphQLCache(),
        ),
      ),
    );
    final tomorrow = DateTime(2026, 1, 2, 10);

    // Priced from the backend catalog: 2 x 2500 + 1 x 1200.
    final order = await repo().createOrder(
      userId: 'user-1',
      items: {'1': 2, '3': 1},
      scheduledAt: tomorrow,
    );
    expect(order.status, OrderStatus.pending);
    expect(order.totalCents, 6200);
    expect(order.expiresAt, clock.add(const Duration(minutes: 2)));
    expect(order.scheduledAt, tomorrow);

    expect((await repo().getOrder(order.id))!.totalCents, 6200);
    expect(await repo().getOrder('missing'), isNull);

    final declined = await repo().payOrder(order.id, 'tok_declined');
    expect(declined.status, OrderStatus.failed);
    final paid = await repo().payOrder(order.id, 'tok_visa_4242');
    expect(paid.status, OrderStatus.paid);

    clock = clock.add(const Duration(seconds: 1));
    final late = await repo().createOrder(
      userId: 'user-1',
      items: {'2': 1},
      scheduledAt: tomorrow,
    );
    clock = clock.add(const Duration(minutes: 2));
    expect((await repo().getOrder(late.id))!.status, OrderStatus.expired);
    expect(
      (await repo().payOrder(late.id, 'tok_visa_4242')).status,
      OrderStatus.expired,
    );
    // A paid order stays paid after its expiry time.
    expect((await repo().getOrder(order.id))!.status, OrderStatus.paid);

    await expectLater(
      repo().createOrder(
        userId: 'u',
        items: {'nope': 1},
        scheduledAt: tomorrow,
      ),
      throwsA(isA<OperationException>()),
    );
    await expectLater(
      repo().createOrder(userId: 'u', items: {'1': 1}, scheduledAt: clock),
      throwsA(isA<OperationException>()),
    );
  });

  test('a payment in flight survives a refresh and is not sent twice', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    var clock = DateTime(2026, 1, 1, 12);
    CheckoutRepositoryImpl repo({Duration delay = Duration.zero}) =>
        CheckoutRepositoryImpl(
          CheckoutRemoteDataSource(
            GraphQLClient(
              link: LocalLink(prefs, now: () => clock, paymentDelay: delay),
              cache: GraphQLCache(),
            ),
          ),
        );
    final order = await repo().createOrder(
      userId: 'user-1',
      items: {'1': 1},
      scheduledAt: DateTime(2026, 1, 2, 10),
    );

    // The tab closes mid-payment, so this request never returns.
    unawaited(
      repo(delay: const Duration(seconds: 2))
          .payOrder(order.id, 'tok_visa_4242'),
    );
    await Future<void>.delayed(const Duration(milliseconds: 50));
    expect((await repo().getOrder(order.id))!.status, OrderStatus.processing);

    // A second attempt is refused and can't change the first one's outcome.
    final retry = await repo().payOrder(order.id, 'tok_declined');
    expect(retry.status, OrderStatus.processing);

    // Long past both processing time and expiry: settled as the first payment.
    clock = clock.add(const Duration(minutes: 5));
    expect((await repo().getOrder(order.id))!.status, OrderStatus.paid);
  });
}

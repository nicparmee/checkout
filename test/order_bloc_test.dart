import 'package:checkout/features/checkout/domain/entities/order.dart';
import 'package:checkout/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:checkout/features/checkout/presentation/bloc/order_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRepository implements CheckoutRepository {
  int payCalls = 0;

  Order _order(OrderStatus status) => Order(
    id: '1',
    status: status,
    scheduledAt: DateTime.now().add(const Duration(days: 1)),
    expiresAt: DateTime.now().add(const Duration(minutes: 2)),
    totalCents: 2500,
  );

  @override
  Future<Order?> getOrder(String id) async => _order(OrderStatus.pending);

  @override
  Future<Order> payOrder(String orderId, String cardToken) async {
    payCalls++;
    await Future<void>.delayed(const Duration(milliseconds: 20));
    return _order(OrderStatus.paid);
  }

  @override
  Future<Order> createOrder({
    required String userId,
    required Map<String, int> items,
    required DateTime scheduledAt,
  }) => throw UnimplementedError();
}

void main() {
  test('repeated pay presses while paying send one payment', () async {
    final repo = _FakeRepository();
    final bloc = OrderBloc(repo, '1')..add(OrderRequested());
    await bloc.stream.firstWhere((s) => s is OrderLoaded);

    bloc
      ..add(PayPressed('tok_visa_4242'))
      ..add(PayPressed('tok_visa_4242'))
      ..add(PayPressed('tok_visa_4242'));
    await bloc.stream.firstWhere(
      (s) => s is OrderLoaded && s.order.status == OrderStatus.paid,
    );
    // Let any (wrongly) queued payments run before counting.
    await Future<void>.delayed(const Duration(milliseconds: 100));

    expect(repo.payCalls, 1);
    await bloc.close();
  });
}

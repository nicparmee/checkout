import '../../../../graphql/schema.graphql.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/checkout_repository.dart';
import '../datasources/checkout_remote_data_source.dart';
import '../models/order.graphql.dart';

class CheckoutRepositoryImpl implements CheckoutRepository {
  CheckoutRepositoryImpl(this._dataSource);

  final CheckoutRemoteDataSource _dataSource;

  @override
  Future<Order> createOrder({
    required String userId,
    required Map<String, int> items,
    required DateTime scheduledAt,
  }) async => _toOrder(
    await _dataSource.createOrder(
      Variables$Mutation$CreateOrder(
        userId: userId,
        items: [
          for (final MapEntry(:key, :value) in items.entries)
            Input$OrderItemInput(productId: key, quantity: value),
        ],
        scheduledAt: scheduledAt.toUtc().toIso8601String(),
      ),
    ),
  );

  @override
  Future<Order?> getOrder(String id) async {
    final order = await _dataSource.getOrder(id);
    return order == null ? null : _toOrder(order);
  }

  @override
  Future<Order> payOrder(String orderId, String cardToken) async =>
      _toOrder(await _dataSource.payOrder(orderId, cardToken));

  Order _toOrder(Fragment$OrderFields o) => Order(
    id: o.id,
    // Throws on an unknown status rather than guessing one.
    status: OrderStatus.values.byName(o.status.name.toLowerCase()),
    scheduledAt: DateTime.parse(o.scheduledAt).toLocal(),
    expiresAt: DateTime.parse(o.expiresAt).toLocal(),
    totalCents: o.totalCents,
  );
}

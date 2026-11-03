import '../entities/order.dart';

abstract interface class CheckoutRepository {
  /// [items] maps product id to quantity; pricing is done by the backend.
  Future<Order> createOrder({
    required String userId,
    required Map<String, int> items,
    required DateTime scheduledAt,
  });

  Future<Order?> getOrder(String id);

  Future<Order> payOrder(String orderId, String cardToken);
}

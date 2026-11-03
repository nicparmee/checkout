enum OrderStatus { pending, processing, paid, failed, expired }

class Order {
  const Order({
    required this.id,
    required this.status,
    required this.scheduledAt,
    required this.expiresAt,
    required this.totalCents,
  });

  final String id;
  final OrderStatus status;
  final DateTime scheduledAt;
  final DateTime expiresAt;
  final int totalCents;

  /// A declined order can be retried until it expires.
  bool get payable =>
      status == OrderStatus.pending || status == OrderStatus.failed;
}

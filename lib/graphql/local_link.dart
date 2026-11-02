import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:gql/ast.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Resolves GraphQL operations in-app instead of over HTTP.
/// Swap for HttpLink (or Link.split) when a real server exists.
class LocalLink extends Link {
  LocalLink(
    this._prefs, {
    DateTime Function()? now,
    this.paymentDelay = const Duration(seconds: 2),
  }) : _now = now ?? DateTime.now;

  final SharedPreferences _prefs;
  final DateTime Function() _now;

  /// Simulated payment provider latency.
  final Duration paymentDelay;

  static const _orderTtl = Duration(minutes: 2);
  static const _declinedToken = 'tok_declined';

  // ponytail: returns whole objects regardless of the selected fields;
  // fine while queries ask for everything, add field filtering if that changes.
  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final name = request.operation.document.definitions
        .whereType<OperationDefinitionNode>()
        .first
        .name
        ?.value;
    final vars = request.variables;
    try {
      final data = switch (name) {
        'Products' => {'products': _products},
        'Order' => {'order': _order(vars['id'] as String)},
        'CreateOrder' => {'createOrder': _createOrder(vars)},
        'PayOrder' => {
          'payOrder': await _payOrder(
            vars['orderId'] as String,
            vars['cardToken'] as String,
          ),
        },
        _ => throw 'No local resolver for $name',
      };
      yield Response(data: data, response: const {});
    } on String catch (message) {
      yield Response(
        errors: [GraphQLError(message: message)],
        response: const {},
      );
    }
  }

  // ponytail: orders persist in this device's prefs, standing in for a
  // database; they vanish with the browser's site data.
  Map<String, dynamic>? _order(String id) {
    final json = _prefs.getString('order:$id');
    if (json == null) return null;
    final order = jsonDecode(json) as Map<String, dynamic>;
    // Settling and expiry are applied on read, so no background job is needed
    // and a payment still completes if the tab closed mid-way.
    if (order['status'] == 'PROCESSING' &&
        !_now().isBefore(DateTime.parse(order['processingUntil'] as String))) {
      _settle(order);
    } else if (_payable(order) &&
        !_now().isBefore(DateTime.parse(order['expiresAt'] as String))) {
      order['status'] = 'EXPIRED';
      _save(order);
    }
    return order;
  }

  Map<String, dynamic> _createOrder(Map<String, dynamic> vars) {
    final items = (vars['items'] as List).cast<Map<String, dynamic>>();
    if (items.isEmpty) throw 'Order has no items';
    // Priced from the server's own catalog; the client never sends prices.
    var total = 0;
    for (final item in items) {
      final product = _products
          .where((p) => p['id'] == item['productId'])
          .firstOrNull;
      final quantity = item['quantity'] as int;
      if (product == null || quantity < 1) {
        throw 'Invalid item ${item['productId']}';
      }
      total += (product['priceCents'] as int) * quantity;
    }
    final now = _now();
    final scheduledAt = DateTime.tryParse(vars['scheduledAt'] as String);
    if (scheduledAt == null || !scheduledAt.isAfter(now)) {
      throw 'Scheduled time must be in the future';
    }
    final order = {
      'id': now.microsecondsSinceEpoch.toString(),
      'userId': vars['userId'],
      'items': items,
      'scheduledAt': scheduledAt.toUtc().toIso8601String(),
      'expiresAt': now.add(_orderTtl).toUtc().toIso8601String(),
      'status': 'PENDING',
      'totalCents': total,
    };
    _save(order);
    return order;
  }

  /// Any token pays except [_declinedToken]; a declined order can retry.
  /// Saved as PROCESSING first, so a repeat call (refresh, second tab) can't
  /// charge again while the first payment is under way.
  Future<Map<String, dynamic>> _payOrder(String id, String cardToken) async {
    final order = _order(id);
    if (order == null) throw 'Order $id not found';
    if (!_payable(order)) return order;
    order
      ..['status'] = 'PROCESSING'
      ..['processingUntil'] = _now().add(paymentDelay).toUtc().toIso8601String()
      ..['outcome'] = cardToken == _declinedToken ? 'FAILED' : 'PAID';
    _save(order);
    await Future<void>.delayed(paymentDelay);
    // A read during the delay may already have settled it.
    final current = _order(id)!;
    if (current['status'] == 'PROCESSING') _settle(current);
    return current;
  }

  void _settle(Map<String, dynamic> order) {
    order['status'] = order.remove('outcome');
    order.remove('processingUntil');
    _save(order);
  }

  bool _payable(Map<String, dynamic> order) =>
      order['status'] == 'PENDING' || order['status'] == 'FAILED';

  void _save(Map<String, dynamic> order) =>
      _prefs.setString('order:${order['id']}', jsonEncode(order));
}

const _products = [
  {
    'id': '1',
    'name': 'Classic Tee',
    'description': 'Soft cotton t-shirt in a relaxed fit.',
    'imageUrl': 'https://picsum.photos/seed/tee/400/300',
    'priceCents': 2500,
  },
  {
    'id': '2',
    'name': 'Canvas Tote',
    'description': 'Sturdy everyday bag with an inner pocket.',
    'imageUrl': 'https://picsum.photos/seed/tote/400/300',
    'priceCents': 1800,
  },
  {
    'id': '3',
    'name': 'Ceramic Mug',
    'description': 'Holds 350ml. Dishwasher and microwave safe.',
    'imageUrl': 'https://picsum.photos/seed/mug/400/300',
    'priceCents': 1200,
  },
];

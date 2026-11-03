import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:gql/ast.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Resolves GraphQL operations in-app instead of over HTTP.
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

  // orders persist in this device's prefs, standing in for a
  // database; they vanish with the browser's site data.
  Map<String, dynamic>? _order(String id) {
    final json = _prefs.getString('order:$id');
    if (json == null) return null;
    final order = jsonDecode(json) as Map<String, dynamic>;
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
    'name': 'Hair cut - quick',
    'description': 'Buzz cut no fuss.',
    'imageUrl': 'https://images.unsplash.com/photo-1634480257305-7f4ca3582e6a?w=400&h=300&fit=crop',
    'priceCents': 2500,
  },
  {
    'id': '2',
    'name': 'Perm',
    'description': 'Sturdy everyday hairstyle',
    'imageUrl': 'https://images.unsplash.com/photo-1739825353871-2b9c6716142a?w=400&h=300&fit=crop',
    'priceCents': 1800,
  },
  {
    'id': '3',
    'name': 'Cut and dye',
    'description': 'Make a new you',
    'imageUrl': 'https://images.unsplash.com/photo-1605980625982-b128a7e7fde2?w=400&h=300&fit=crop',
    'priceCents': 1200,
  },
];

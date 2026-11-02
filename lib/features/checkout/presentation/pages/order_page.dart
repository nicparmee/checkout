// order page with state
// states:
// order on hold
// order - payment successful
// order - payment unsuccessful
// order - expired
import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Order $orderId')));
  }
}

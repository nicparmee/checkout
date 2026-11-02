import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Summary')),
      body: Center(
        child: FilledButton(
          onPressed: () => context.go('/order/123'),
          child: const Text('Place order'),
        ),
      ),
    );
  }
}

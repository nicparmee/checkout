import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/format_price.dart';
import '../../../cart/presentation/bloc/cart_cubit.dart';
import '../../../cart/presentation/widgets/add_to_cart_button.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final lines = context.watch<CartCubit>().state.values.toList();
    final total = context.select((CartCubit c) => c.totalCents);
    final text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Summary')),
      body: lines.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                for (final line in lines)
                  ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        line.product.imageUrl,
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                        semanticLabel: line.product.name,
                        errorBuilder: (_, _, _) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    ),
                    title: Text(line.product.name),
                    subtitle: Text(
                      formatPrice(line.product.priceCents * line.quantity),
                    ),
                    trailing: AddToCartButton(product: line.product),
                  ),
              ],
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'Total ${formatPrice(total)}',
                  style: text.titleLarge,
                ),
              ),
              FilledButton(
                onPressed: lines.isEmpty
                    ? null
                    : () => context.go('/order/123'),
                child: const Text('Place order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

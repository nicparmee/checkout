import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql/client.dart';

import '../../../../shared/format_price.dart';
import '../../../authentication/presentation/bloc/auth_cubit.dart';
import '../../../cart/presentation/bloc/cart_cubit.dart';
import '../../../cart/presentation/widgets/add_to_cart_button.dart';
import '../../data/datasources/checkout_remote_data_source.dart';
import '../../data/repositories/checkout_repository_impl.dart';

// ponytail: fixed hourly slots tomorrow; fetch real availability when there's a backend.
const _slotHours = [9, 10, 11, 13, 14, 15, 16];

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  DateTime? _slot;
  bool _placing = false;

  Future<void> _placeOrder(String userId) async {
    final cart = context.read<CartCubit>();
    setState(() => _placing = true);
    try {
      final order =
          await CheckoutRepositoryImpl(
            CheckoutRemoteDataSource(context.read<GraphQLClient>()),
          ).createOrder(
            userId: userId,
            items: {
              for (final l in cart.state.values) l.product.id: l.quantity,
            },
            scheduledAt: _slot!,
          );
      // Cleared once the order exists, so it can't be placed twice.
      cart.clear();
      if (mounted) context.go('/order/${order.id}');
    } catch (e) {
      if (!mounted) return;
      setState(() => _placing = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not place order: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final lines = context.watch<CartCubit>().state.values.toList();
    final total = context.select((CartCubit c) => c.totalCents);
    final userId = context.watch<AuthCubit>().state;
    final text = Theme.of(context).textTheme;
    final localizations = MaterialLocalizations.of(context);
    final now = DateTime.now();
    final slots = [
      for (final h in _slotHours) DateTime(now.year, now.month, now.day + 1, h),
    ];

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
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Appointment time (tomorrow)',
                        style: text.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final slot in slots)
                            ChoiceChip(
                              label: Text(
                                localizations.formatTimeOfDay(
                                  TimeOfDay.fromDateTime(slot),
                                ),
                              ),
                              selected: _slot == slot,
                              onSelected: (_) => setState(() => _slot = slot),
                            ),
                        ],
                      ),
                    ],
                  ),
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
                    : userId == null
                    ? () => context.push('/sign-in')
                    : _slot == null || _placing
                    ? null
                    : () => _placeOrder(userId),
                child: Text(
                  userId == null ? 'Sign in to order' : 'Place order',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

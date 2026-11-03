import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql/client.dart';

import '../../../../shared/format_price.dart';
import '../../../../shared/white_text_theme.dart';
import '../../../cart/presentation/bloc/cart_cubit.dart';
import '../../data/datasources/checkout_remote_data_source.dart';
import '../../data/repositories/checkout_repository_impl.dart';
import '../../domain/entities/order.dart';
import '../bloc/order_bloc.dart';

// hardcoded saved cards; load from the payment provider once one exists.
const _savedCards = [
  (token: 'tok_visa_4242', label: 'Visa •••• 4242'),
  (token: 'tok_declined', label: 'Mastercard •••• 0002 (declines)'),
];

class OrderPage extends StatelessWidget {
  const OrderPage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(
        CheckoutRepositoryImpl(
          CheckoutRemoteDataSource(context.read<GraphQLClient>()),
        ),
        orderId,
      )..add(OrderRequested()),
      child: Theme(
        data: whiteTextTheme(Theme.of(context)),
        child: Scaffold(
          appBar: AppBar(title: Text('Order $orderId')),
          body: BlocBuilder<OrderBloc, OrderState>(
            builder: (context, state) => switch (state) {
              OrderLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              OrderNotFound() => const Center(child: Text('Order not found')),
              OrderError(:final message) => Center(child: Text(message)),
              OrderLoaded() => _OrderDetails(state),
            },
          ),
        ),
      ),
    );
  }
}

class _OrderDetails extends StatefulWidget {
  const _OrderDetails(this.state);

  final OrderLoaded state;

  @override
  State<_OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<_OrderDetails> {
  String? _cardToken;

  @override
  Widget build(BuildContext context) {
    final OrderLoaded(:order, :remaining, :paying) = widget.state;
    final text = Theme.of(context).textTheme;
    final localizations = MaterialLocalizations.of(context);
    final seconds = (remaining.inSeconds % 60).toString().padLeft(2, '0');
    final processing = [
      const Center(child: CircularProgressIndicator()),
      const SizedBox(height: 16),
      Text(
        'Processing payment…',
        style: text.titleMedium,
        textAlign: TextAlign.center,
      ),
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.event),
          title: const Text('Appointment'),
          subtitle: Text(
            '${localizations.formatMediumDate(order.scheduledAt)}, '
            '${localizations.formatTimeOfDay(TimeOfDay.fromDateTime(order.scheduledAt))}',
          ),
        ),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.receipt_long),
          title: const Text('Total'),
          subtitle: Text(formatPrice(order.totalCents)),
        ),
        const SizedBox(height: 16),
        ...switch (order.status) {
          OrderStatus.paid => [
            const _Outcome(Icons.check_circle, 'Payment successful'),
          ],
          OrderStatus.expired => [
            const _Outcome(Icons.timer_off, 'This order has expired'),
          ],
          OrderStatus.processing => processing,
          _ when paying => processing,
          OrderStatus.pending || OrderStatus.failed => [
            Text(
              'Expires in ${remaining.inMinutes}:$seconds',
              style: text.titleMedium,
            ),
            if (order.status == OrderStatus.failed) ...[
              const SizedBox(height: 8),
              Text(
                'Payment declined. Try another card.',
                style: text.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _cardToken,
              dropdownColor: Colors.grey.shade800,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Saved card',
                prefixIcon: Icon(Icons.credit_card),
              ),
              items: [
                for (final card in _savedCards)
                  DropdownMenuItem(value: card.token, child: Text(card.label)),
              ],
              onChanged: (token) => setState(() => _cardToken = token),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _cardToken == null
                  ? null
                  : () {
                      context.read<CartCubit>().clear();
                      context.read<OrderBloc>().add(PayPressed(_cardToken!));
                    },
              child: Text(
                'Pay ${formatPrice(order.totalCents)} and confirm order',
              ),
            ),
          ],
        },
      ],
    );
  }
}

class _Outcome extends StatelessWidget {
  const _Outcome(this.icon, this.message);

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 64),
        const SizedBox(height: 8),
        Text(message, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () => context.go('/catalog'),
          child: const Text('Back to catalog'),
        ),
      ],
    );
  }
}

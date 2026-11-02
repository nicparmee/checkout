import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../catalog/domain/entities/product.dart';
import '../bloc/cart_cubit.dart';

/// "Add" button that turns into a − qty + stepper once the product is in the cart.
class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final cart = context.read<CartCubit>();
    final quantity = context.select((CartCubit c) => c.quantityOf(product.id));

    if (quantity == 0) {
      return FilledButton.tonalIcon(
        onPressed: () => cart.add(product),
        icon: const Icon(Icons.add_shopping_cart),
        label: const Text('Add'),
      );
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton.outlined(
          tooltip: 'Remove one ${product.name}',
          onPressed: () => cart.remove(product),
          icon: Icon(quantity == 1 ? Icons.delete_outline : Icons.remove),
        ),
        SizedBox(
          width: 32,
          child: Text(
            '$quantity',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        IconButton.filledTonal(
          tooltip: 'Add one ${product.name}',
          onPressed: () => cart.add(product),
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

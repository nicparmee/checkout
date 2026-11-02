import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../catalog/domain/entities/product.dart';

typedef CartLine = ({Product product, int quantity});

/// In-memory cart, keyed by product id. Map keeps insertion order for display.
class CartCubit extends Cubit<Map<String, CartLine>> {
  CartCubit() : super(const {});

  int quantityOf(String productId) => state[productId]?.quantity ?? 0;

  int get count => state.values.fold(0, (sum, l) => sum + l.quantity);

  int get totalCents =>
      state.values.fold(0, (sum, l) => sum + l.product.priceCents * l.quantity);

  void add(Product product) => _set(product, quantityOf(product.id) + 1);

  void remove(Product product) => _set(product, quantityOf(product.id) - 1);

  void clear() => emit(const {});

  void _set(Product product, int quantity) {
    final next = {...state};
    if (quantity <= 0) {
      next.remove(product.id);
    } else {
      next[product.id] = (product: product, quantity: quantity);
    }
    emit(next);
  }
}

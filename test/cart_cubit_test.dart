import 'package:checkout/features/cart/presentation/bloc/cart_cubit.dart';
import 'package:checkout/features/catalog/domain/entities/product.dart';
import 'package:flutter_test/flutter_test.dart';

Product _product(String id, int priceCents) => Product(
  id: id,
  name: id,
  description: '',
  imageUrl: '',
  priceCents: priceCents,
);

void main() {
  test('add/remove updates quantities, count and total', () {
    final cart = CartCubit();
    final tee = _product('tee', 2500);
    final mug = _product('mug', 1200);

    cart
      ..add(tee)
      ..add(tee)
      ..add(mug);
    expect(cart.quantityOf('tee'), 2);
    expect(cart.count, 3);
    expect(cart.totalCents, 6200);

    cart
      ..remove(mug)
      ..remove(mug); // removing past zero is a no-op
    expect(cart.state.containsKey('mug'), isFalse);
    expect(cart.count, 2);
  });
}

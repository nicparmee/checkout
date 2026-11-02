import 'package:flutter/material.dart';

import '../../../cart/presentation/widgets/add_to_cart_button.dart';
import '../../../../shared/format_price.dart';
import '../../domain/entities/product.dart';

class CatalogItem extends StatelessWidget {
  const CatalogItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Card(
      clipBehavior: Clip.antiAlias,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final imageSize = (constraints.maxWidth * 0.25).clamp(64.0, 160.0);
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox.square(
                dimension: imageSize,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    semanticLabel: product.name,
                    errorBuilder: (_, _, _) =>
                        const Center(child: Icon(Icons.image_not_supported)),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name, style: text.titleMedium),
                      const SizedBox(height: 4),
                      Text(product.description, style: text.bodyMedium),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              formatPrice(product.priceCents),
                              style: text.titleMedium,
                            ),
                          ),
                          AddToCartButton(product: product),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

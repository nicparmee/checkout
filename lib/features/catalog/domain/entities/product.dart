class Product {
  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.priceCents,
  });

  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int priceCents;
}

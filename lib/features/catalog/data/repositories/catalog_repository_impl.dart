import '../../domain/entities/product.dart';
import '../../domain/repositories/catalog_repository.dart';
import '../datasources/catalog_remote_data_source.dart';

class CatalogRepositoryImpl implements CatalogRepository {
  CatalogRepositoryImpl(this._dataSource);

  final CatalogRemoteDataSource _dataSource;

  @override
  Future<List<Product>> getProducts() async {
    final products = await _dataSource.getProducts();
    return products
        .map(
          (p) => Product(
            id: p.id,
            name: p.name,
            description: p.description,
            imageUrl: p.imageUrl,
            priceCents: p.priceCents,
          ),
        )
        .toList();
  }
}

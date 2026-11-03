import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/catalog_repository.dart';
import '../../domain/entities/product.dart';

sealed class CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  CatalogLoaded(this.products);
  final List<Product> products;
}

class CatalogError extends CatalogState {
  CatalogError(this.message);
  final String message;
}

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit(this._repository) : super(CatalogLoading());

  final CatalogRepository _repository;

  Future<void> load() async {
    emit(CatalogLoading());
    try {
      final products = await _repository.getProducts();
      if (!isClosed) emit(CatalogLoaded(products));
    } catch (e) {
      if (!isClosed) emit(CatalogError(e.toString()));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql/client.dart';

import '../../data/datasources/catalog_remote_data_source.dart';
import '../../data/repositories/catalog_repository_impl.dart';
import '../bloc/catalog_cubit.dart';
import '../widget/catalog_item.dart';

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CatalogCubit(
        CatalogRepositoryImpl(
          CatalogRemoteDataSource(context.read<GraphQLClient>()),
        ),
      )..load(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Catalog'),
          actions: [
            TextButton(
              onPressed: () => context.go('/summary'),
              child: const Text('Go to summary'),
            ),
          ],
        ),
        body: BlocBuilder<CatalogCubit, CatalogState>(
          builder: (context, state) => switch (state) {
            CatalogLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
            CatalogError(:final message) => Center(child: Text(message)),
            CatalogLoaded(:final products) => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              itemBuilder: (_, i) => CatalogItem(product: products[i]),
            ),
          },
        ),
      ),
    );
  }
}

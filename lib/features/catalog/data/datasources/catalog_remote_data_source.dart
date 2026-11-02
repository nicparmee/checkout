import 'package:graphql/client.dart';

import '../models/products.graphql.dart';

class CatalogRemoteDataSource {
  CatalogRemoteDataSource(this._client);

  final GraphQLClient _client;

  Future<List<Query$Products$products>> getProducts() async {
    final result = await _client.query$Products(
      Options$Query$Products(fetchPolicy: FetchPolicy.noCache),
    );
    if (result.hasException) throw result.exception!;
    return result.parsedData!.products;
  }
}

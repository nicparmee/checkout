import 'package:graphql/client.dart';

import '../models/order.graphql.dart';

class CheckoutRemoteDataSource {
  CheckoutRemoteDataSource(this._client);

  final GraphQLClient _client;

  Future<Fragment$OrderFields> createOrder(
    Variables$Mutation$CreateOrder variables,
  ) async {
    final result = await _client.mutate$CreateOrder(
      Options$Mutation$CreateOrder(
        variables: variables,
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (result.hasException) throw result.exception!;
    return result.parsedData!.createOrder;
  }

  Future<Fragment$OrderFields?> getOrder(String id) async {
    final result = await _client.query$Order(
      Options$Query$Order(
        variables: Variables$Query$Order(id: id),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (result.hasException) throw result.exception!;
    return result.parsedData!.order;
  }

  Future<Fragment$OrderFields> payOrder(
    String orderId,
    String cardToken,
  ) async {
    final result = await _client.mutate$PayOrder(
      Options$Mutation$PayOrder(
        variables: Variables$Mutation$PayOrder(
          orderId: orderId,
          cardToken: cardToken,
        ),
        fetchPolicy: FetchPolicy.noCache,
      ),
    );
    if (result.hasException) throw result.exception!;
    return result.parsedData!.payOrder;
  }
}

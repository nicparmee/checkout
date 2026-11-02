import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Query$Products {
  Query$Products({required this.products});

  factory Query$Products.fromJson(Map<String, dynamic> json) {
    final l$products = json['products'];
    return Query$Products(
      products: (l$products as List<dynamic>)
          .map(
            (e) =>
                Query$Products$products.fromJson((e as Map<String, dynamic>)),
          )
          .toList(),
    );
  }

  final List<Query$Products$products> products;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$products = products;
    _resultData['products'] = l$products.map((e) => e.toJson()).toList();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$products = products;
    return Object.hashAll([Object.hashAll(l$products.map((v) => v))]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Products || runtimeType != other.runtimeType) {
      return false;
    }
    final l$products = products;
    final lOther$products = other.products;
    if (l$products.length != lOther$products.length) {
      return false;
    }
    for (int i = 0; i < l$products.length; i++) {
      final l$products$entry = l$products[i];
      final lOther$products$entry = lOther$products[i];
      if (l$products$entry != lOther$products$entry) {
        return false;
      }
    }
    return true;
  }
}

extension UtilityExtension$Query$Products on Query$Products {
  CopyWith$Query$Products<Query$Products> get copyWith =>
      CopyWith$Query$Products(this, (i) => i);
}

abstract class CopyWith$Query$Products<TRes> {
  factory CopyWith$Query$Products(
    Query$Products instance,
    TRes Function(Query$Products) then,
  ) = _CopyWithImpl$Query$Products;

  factory CopyWith$Query$Products.stub(TRes res) =
      _CopyWithStubImpl$Query$Products;

  TRes call({List<Query$Products$products>? products});
  TRes products(
    Iterable<Query$Products$products> Function(
      Iterable<CopyWith$Query$Products$products<Query$Products$products>>,
    )
    _fn,
  );
}

class _CopyWithImpl$Query$Products<TRes>
    implements CopyWith$Query$Products<TRes> {
  _CopyWithImpl$Query$Products(this._instance, this._then);

  final Query$Products _instance;

  final TRes Function(Query$Products) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? products = _undefined}) => _then(
    Query$Products(
      products: products == _undefined || products == null
          ? _instance.products
          : (products as List<Query$Products$products>),
    ),
  );

  TRes products(
    Iterable<Query$Products$products> Function(
      Iterable<CopyWith$Query$Products$products<Query$Products$products>>,
    )
    _fn,
  ) => call(
    products: _fn(
      _instance.products.map(
        (e) => CopyWith$Query$Products$products(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Query$Products<TRes>
    implements CopyWith$Query$Products<TRes> {
  _CopyWithStubImpl$Query$Products(this._res);

  TRes _res;

  call({List<Query$Products$products>? products}) => _res;

  products(_fn) => _res;
}

const documentNodeQueryProducts = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Products'),
      variableDefinitions: [],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'products'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'name'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'description'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
                FieldNode(
                  name: NameNode(value: 'imageUrl'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ],
);
Query$Products _parserFn$Query$Products(Map<String, dynamic> data) =>
    Query$Products.fromJson(data);
typedef OnQueryComplete$Query$Products = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$Products?,
);

class Options$Query$Products extends graphql.QueryOptions<Query$Products> {
  Options$Query$Products({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Products? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$Products? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         pollInterval: pollInterval,
         context: context,
         onComplete: onComplete == null
             ? null
             : (data) => onComplete(
                 data,
                 data == null ? null : _parserFn$Query$Products(data),
               ),
         onError: onError,
         document: documentNodeQueryProducts,
         parserFn: _parserFn$Query$Products,
       );

  final OnQueryComplete$Query$Products? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$Products
    extends graphql.WatchQueryOptions<Query$Products> {
  WatchOptions$Query$Products({
    String? operationName,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Products? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryProducts,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$Products,
       );
}

class FetchMoreOptions$Query$Products extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$Products({required graphql.UpdateQuery updateQuery})
    : super(updateQuery: updateQuery, document: documentNodeQueryProducts);
}

extension ClientExtension$Query$Products on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$Products>> query$Products([
    Options$Query$Products? options,
  ]) async => await this.query(options ?? Options$Query$Products());

  graphql.ObservableQuery<Query$Products> watchQuery$Products([
    WatchOptions$Query$Products? options,
  ]) => this.watchQuery(options ?? WatchOptions$Query$Products());

  void writeQuery$Products({
    required Query$Products data,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryProducts),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Query$Products? readQuery$Products({bool optimistic = true}) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryProducts),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$Products.fromJson(result);
  }
}

class Query$Products$products {
  Query$Products$products({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory Query$Products$products.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$description = json['description'];
    final l$imageUrl = json['imageUrl'];
    return Query$Products$products(
      id: (l$id as String),
      name: (l$name as String),
      description: (l$description as String),
      imageUrl: (l$imageUrl as String),
    );
  }

  final String id;

  final String name;

  final String description;

  final String imageUrl;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$imageUrl = imageUrl;
    _resultData['imageUrl'] = l$imageUrl;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$description = description;
    final l$imageUrl = imageUrl;
    return Object.hashAll([l$id, l$name, l$description, l$imageUrl]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Products$products || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$imageUrl = imageUrl;
    final lOther$imageUrl = other.imageUrl;
    if (l$imageUrl != lOther$imageUrl) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Products$products on Query$Products$products {
  CopyWith$Query$Products$products<Query$Products$products> get copyWith =>
      CopyWith$Query$Products$products(this, (i) => i);
}

abstract class CopyWith$Query$Products$products<TRes> {
  factory CopyWith$Query$Products$products(
    Query$Products$products instance,
    TRes Function(Query$Products$products) then,
  ) = _CopyWithImpl$Query$Products$products;

  factory CopyWith$Query$Products$products.stub(TRes res) =
      _CopyWithStubImpl$Query$Products$products;

  TRes call({String? id, String? name, String? description, String? imageUrl});
}

class _CopyWithImpl$Query$Products$products<TRes>
    implements CopyWith$Query$Products$products<TRes> {
  _CopyWithImpl$Query$Products$products(this._instance, this._then);

  final Query$Products$products _instance;

  final TRes Function(Query$Products$products) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? description = _undefined,
    Object? imageUrl = _undefined,
  }) => _then(
    Query$Products$products(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      name: name == _undefined || name == null
          ? _instance.name
          : (name as String),
      description: description == _undefined || description == null
          ? _instance.description
          : (description as String),
      imageUrl: imageUrl == _undefined || imageUrl == null
          ? _instance.imageUrl
          : (imageUrl as String),
    ),
  );
}

class _CopyWithStubImpl$Query$Products$products<TRes>
    implements CopyWith$Query$Products$products<TRes> {
  _CopyWithStubImpl$Query$Products$products(this._res);

  TRes _res;

  call({String? id, String? name, String? description, String? imageUrl}) =>
      _res;
}

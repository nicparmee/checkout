import '../../../../graphql/schema.graphql.dart';

import 'dart:async';

import 'package:gql/ast.dart';
import 'package:graphql/client.dart' as graphql;

class Fragment$OrderFields {
  Fragment$OrderFields({
    required this.id,
    required this.userId,
    required this.items,
    required this.scheduledAt,
    required this.expiresAt,
    required this.status,
    required this.totalCents,
  });

  factory Fragment$OrderFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$userId = json['userId'];
    final l$items = json['items'];
    final l$scheduledAt = json['scheduledAt'];
    final l$expiresAt = json['expiresAt'];
    final l$status = json['status'];
    final l$totalCents = json['totalCents'];
    return Fragment$OrderFields(
      id: (l$id as String),
      userId: (l$userId as String),
      items: (l$items as List<dynamic>)
          .map(
            (e) => Fragment$OrderFields$items.fromJson(
              (e as Map<String, dynamic>),
            ),
          )
          .toList(),
      scheduledAt: (l$scheduledAt as String),
      expiresAt: (l$expiresAt as String),
      status: fromJson$Enum$OrderStatus((l$status as String)),
      totalCents: (l$totalCents as int),
    );
  }

  final String id;

  final String userId;

  final List<Fragment$OrderFields$items> items;

  final String scheduledAt;

  final String expiresAt;

  final Enum$OrderStatus status;

  final int totalCents;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$userId = userId;
    _resultData['userId'] = l$userId;
    final l$items = items;
    _resultData['items'] = l$items.map((e) => e.toJson()).toList();
    final l$scheduledAt = scheduledAt;
    _resultData['scheduledAt'] = l$scheduledAt;
    final l$expiresAt = expiresAt;
    _resultData['expiresAt'] = l$expiresAt;
    final l$status = status;
    _resultData['status'] = toJson$Enum$OrderStatus(l$status);
    final l$totalCents = totalCents;
    _resultData['totalCents'] = l$totalCents;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$userId = userId;
    final l$items = items;
    final l$scheduledAt = scheduledAt;
    final l$expiresAt = expiresAt;
    final l$status = status;
    final l$totalCents = totalCents;
    return Object.hashAll([
      l$id,
      l$userId,
      Object.hashAll(l$items.map((v) => v)),
      l$scheduledAt,
      l$expiresAt,
      l$status,
      l$totalCents,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$OrderFields || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$items = items;
    final lOther$items = other.items;
    if (l$items.length != lOther$items.length) {
      return false;
    }
    for (int i = 0; i < l$items.length; i++) {
      final l$items$entry = l$items[i];
      final lOther$items$entry = lOther$items[i];
      if (l$items$entry != lOther$items$entry) {
        return false;
      }
    }
    final l$scheduledAt = scheduledAt;
    final lOther$scheduledAt = other.scheduledAt;
    if (l$scheduledAt != lOther$scheduledAt) {
      return false;
    }
    final l$expiresAt = expiresAt;
    final lOther$expiresAt = other.expiresAt;
    if (l$expiresAt != lOther$expiresAt) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$totalCents = totalCents;
    final lOther$totalCents = other.totalCents;
    if (l$totalCents != lOther$totalCents) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$OrderFields on Fragment$OrderFields {
  CopyWith$Fragment$OrderFields<Fragment$OrderFields> get copyWith =>
      CopyWith$Fragment$OrderFields(this, (i) => i);
}

abstract class CopyWith$Fragment$OrderFields<TRes> {
  factory CopyWith$Fragment$OrderFields(
    Fragment$OrderFields instance,
    TRes Function(Fragment$OrderFields) then,
  ) = _CopyWithImpl$Fragment$OrderFields;

  factory CopyWith$Fragment$OrderFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$OrderFields;

  TRes call({
    String? id,
    String? userId,
    List<Fragment$OrderFields$items>? items,
    String? scheduledAt,
    String? expiresAt,
    Enum$OrderStatus? status,
    int? totalCents,
  });
  TRes items(
    Iterable<Fragment$OrderFields$items> Function(
      Iterable<CopyWith$Fragment$OrderFields$items<Fragment$OrderFields$items>>,
    )
    _fn,
  );
}

class _CopyWithImpl$Fragment$OrderFields<TRes>
    implements CopyWith$Fragment$OrderFields<TRes> {
  _CopyWithImpl$Fragment$OrderFields(this._instance, this._then);

  final Fragment$OrderFields _instance;

  final TRes Function(Fragment$OrderFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? userId = _undefined,
    Object? items = _undefined,
    Object? scheduledAt = _undefined,
    Object? expiresAt = _undefined,
    Object? status = _undefined,
    Object? totalCents = _undefined,
  }) => _then(
    Fragment$OrderFields(
      id: id == _undefined || id == null ? _instance.id : (id as String),
      userId: userId == _undefined || userId == null
          ? _instance.userId
          : (userId as String),
      items: items == _undefined || items == null
          ? _instance.items
          : (items as List<Fragment$OrderFields$items>),
      scheduledAt: scheduledAt == _undefined || scheduledAt == null
          ? _instance.scheduledAt
          : (scheduledAt as String),
      expiresAt: expiresAt == _undefined || expiresAt == null
          ? _instance.expiresAt
          : (expiresAt as String),
      status: status == _undefined || status == null
          ? _instance.status
          : (status as Enum$OrderStatus),
      totalCents: totalCents == _undefined || totalCents == null
          ? _instance.totalCents
          : (totalCents as int),
    ),
  );

  TRes items(
    Iterable<Fragment$OrderFields$items> Function(
      Iterable<CopyWith$Fragment$OrderFields$items<Fragment$OrderFields$items>>,
    )
    _fn,
  ) => call(
    items: _fn(
      _instance.items.map(
        (e) => CopyWith$Fragment$OrderFields$items(e, (i) => i),
      ),
    ).toList(),
  );
}

class _CopyWithStubImpl$Fragment$OrderFields<TRes>
    implements CopyWith$Fragment$OrderFields<TRes> {
  _CopyWithStubImpl$Fragment$OrderFields(this._res);

  TRes _res;

  call({
    String? id,
    String? userId,
    List<Fragment$OrderFields$items>? items,
    String? scheduledAt,
    String? expiresAt,
    Enum$OrderStatus? status,
    int? totalCents,
  }) => _res;

  items(_fn) => _res;
}

const fragmentDefinitionOrderFields = FragmentDefinitionNode(
  name: NameNode(value: 'OrderFields'),
  typeCondition: TypeConditionNode(
    on: NamedTypeNode(name: NameNode(value: 'Order'), isNonNull: false),
  ),
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
        name: NameNode(value: 'userId'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'items'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(
          selections: [
            FieldNode(
              name: NameNode(value: 'productId'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
            FieldNode(
              name: NameNode(value: 'quantity'),
              alias: null,
              arguments: [],
              directives: [],
              selectionSet: null,
            ),
          ],
        ),
      ),
      FieldNode(
        name: NameNode(value: 'scheduledAt'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'expiresAt'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'status'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
      FieldNode(
        name: NameNode(value: 'totalCents'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ],
  ),
);
const documentNodeFragmentOrderFields = DocumentNode(
  definitions: [fragmentDefinitionOrderFields],
);

extension ClientExtension$Fragment$OrderFields on graphql.GraphQLClient {
  void writeFragment$OrderFields({
    required Fragment$OrderFields data,
    required Map<String, dynamic> idFields,
    bool broadcast = true,
  }) => this.writeFragment(
    graphql.FragmentRequest(
      idFields: idFields,
      fragment: const graphql.Fragment(
        fragmentName: 'OrderFields',
        document: documentNodeFragmentOrderFields,
      ),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Fragment$OrderFields? readFragment$OrderFields({
    required Map<String, dynamic> idFields,
    bool optimistic = true,
  }) {
    final result = this.readFragment(
      graphql.FragmentRequest(
        idFields: idFields,
        fragment: const graphql.Fragment(
          fragmentName: 'OrderFields',
          document: documentNodeFragmentOrderFields,
        ),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Fragment$OrderFields.fromJson(result);
  }
}

class Fragment$OrderFields$items {
  Fragment$OrderFields$items({required this.productId, required this.quantity});

  factory Fragment$OrderFields$items.fromJson(Map<String, dynamic> json) {
    final l$productId = json['productId'];
    final l$quantity = json['quantity'];
    return Fragment$OrderFields$items(
      productId: (l$productId as String),
      quantity: (l$quantity as int),
    );
  }

  final String productId;

  final int quantity;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$productId = productId;
    _resultData['productId'] = l$productId;
    final l$quantity = quantity;
    _resultData['quantity'] = l$quantity;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$productId = productId;
    final l$quantity = quantity;
    return Object.hashAll([l$productId, l$quantity]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Fragment$OrderFields$items ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$productId = productId;
    final lOther$productId = other.productId;
    if (l$productId != lOther$productId) {
      return false;
    }
    final l$quantity = quantity;
    final lOther$quantity = other.quantity;
    if (l$quantity != lOther$quantity) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Fragment$OrderFields$items
    on Fragment$OrderFields$items {
  CopyWith$Fragment$OrderFields$items<Fragment$OrderFields$items>
  get copyWith => CopyWith$Fragment$OrderFields$items(this, (i) => i);
}

abstract class CopyWith$Fragment$OrderFields$items<TRes> {
  factory CopyWith$Fragment$OrderFields$items(
    Fragment$OrderFields$items instance,
    TRes Function(Fragment$OrderFields$items) then,
  ) = _CopyWithImpl$Fragment$OrderFields$items;

  factory CopyWith$Fragment$OrderFields$items.stub(TRes res) =
      _CopyWithStubImpl$Fragment$OrderFields$items;

  TRes call({String? productId, int? quantity});
}

class _CopyWithImpl$Fragment$OrderFields$items<TRes>
    implements CopyWith$Fragment$OrderFields$items<TRes> {
  _CopyWithImpl$Fragment$OrderFields$items(this._instance, this._then);

  final Fragment$OrderFields$items _instance;

  final TRes Function(Fragment$OrderFields$items) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? productId = _undefined, Object? quantity = _undefined}) =>
      _then(
        Fragment$OrderFields$items(
          productId: productId == _undefined || productId == null
              ? _instance.productId
              : (productId as String),
          quantity: quantity == _undefined || quantity == null
              ? _instance.quantity
              : (quantity as int),
        ),
      );
}

class _CopyWithStubImpl$Fragment$OrderFields$items<TRes>
    implements CopyWith$Fragment$OrderFields$items<TRes> {
  _CopyWithStubImpl$Fragment$OrderFields$items(this._res);

  TRes _res;

  call({String? productId, int? quantity}) => _res;
}

class Variables$Query$Order {
  factory Variables$Query$Order({required String id}) =>
      Variables$Query$Order._({r'id': id});

  Variables$Query$Order._(this._$data);

  factory Variables$Query$Order.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Variables$Query$Order._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Variables$Query$Order<Variables$Query$Order> get copyWith =>
      CopyWith$Variables$Query$Order(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Query$Order || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

abstract class CopyWith$Variables$Query$Order<TRes> {
  factory CopyWith$Variables$Query$Order(
    Variables$Query$Order instance,
    TRes Function(Variables$Query$Order) then,
  ) = _CopyWithImpl$Variables$Query$Order;

  factory CopyWith$Variables$Query$Order.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Order;

  TRes call({String? id});
}

class _CopyWithImpl$Variables$Query$Order<TRes>
    implements CopyWith$Variables$Query$Order<TRes> {
  _CopyWithImpl$Variables$Query$Order(this._instance, this._then);

  final Variables$Query$Order _instance;

  final TRes Function(Variables$Query$Order) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) => _then(
    Variables$Query$Order._({
      ..._instance._$data,
      if (id != _undefined && id != null) 'id': (id as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Query$Order<TRes>
    implements CopyWith$Variables$Query$Order<TRes> {
  _CopyWithStubImpl$Variables$Query$Order(this._res);

  TRes _res;

  call({String? id}) => _res;
}

class Query$Order {
  Query$Order({this.order});

  factory Query$Order.fromJson(Map<String, dynamic> json) {
    final l$order = json['order'];
    return Query$Order(
      order: l$order == null
          ? null
          : Fragment$OrderFields.fromJson((l$order as Map<String, dynamic>)),
    );
  }

  final Fragment$OrderFields? order;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$order = order;
    _resultData['order'] = l$order?.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$order = order;
    return Object.hashAll([l$order]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Query$Order || runtimeType != other.runtimeType) {
      return false;
    }
    final l$order = order;
    final lOther$order = other.order;
    if (l$order != lOther$order) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Order on Query$Order {
  CopyWith$Query$Order<Query$Order> get copyWith =>
      CopyWith$Query$Order(this, (i) => i);
}

abstract class CopyWith$Query$Order<TRes> {
  factory CopyWith$Query$Order(
    Query$Order instance,
    TRes Function(Query$Order) then,
  ) = _CopyWithImpl$Query$Order;

  factory CopyWith$Query$Order.stub(TRes res) = _CopyWithStubImpl$Query$Order;

  TRes call({Fragment$OrderFields? order});
  CopyWith$Fragment$OrderFields<TRes> get order;
}

class _CopyWithImpl$Query$Order<TRes> implements CopyWith$Query$Order<TRes> {
  _CopyWithImpl$Query$Order(this._instance, this._then);

  final Query$Order _instance;

  final TRes Function(Query$Order) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? order = _undefined}) => _then(
    Query$Order(
      order: order == _undefined
          ? _instance.order
          : (order as Fragment$OrderFields?),
    ),
  );

  CopyWith$Fragment$OrderFields<TRes> get order {
    final local$order = _instance.order;
    return local$order == null
        ? CopyWith$Fragment$OrderFields.stub(_then(_instance))
        : CopyWith$Fragment$OrderFields(local$order, (e) => call(order: e));
  }
}

class _CopyWithStubImpl$Query$Order<TRes>
    implements CopyWith$Query$Order<TRes> {
  _CopyWithStubImpl$Query$Order(this._res);

  TRes _res;

  call({Fragment$OrderFields? order}) => _res;

  CopyWith$Fragment$OrderFields<TRes> get order =>
      CopyWith$Fragment$OrderFields.stub(_res);
}

const documentNodeQueryOrder = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Order'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'id')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'order'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'id'),
                value: VariableNode(name: NameNode(value: 'id')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'OrderFields'),
                  directives: [],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    fragmentDefinitionOrderFields,
  ],
);
Query$Order _parserFn$Query$Order(Map<String, dynamic> data) =>
    Query$Order.fromJson(data);
typedef OnQueryComplete$Query$Order = FutureOr<void> Function(
  Map<String, dynamic>?,
  Query$Order?,
);

class Options$Query$Order extends graphql.QueryOptions<Query$Order> {
  Options$Query$Order({
    String? operationName,
    required Variables$Query$Order variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Order? typedOptimisticResult,
    Duration? pollInterval,
    graphql.Context? context,
    OnQueryComplete$Query$Order? onComplete,
    graphql.OnQueryError? onError,
  }) : onCompleteWithParsed = onComplete,
       super(
         variables: variables.toJson(),
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
                 data == null ? null : _parserFn$Query$Order(data),
               ),
         onError: onError,
         document: documentNodeQueryOrder,
         parserFn: _parserFn$Query$Order,
       );

  final OnQueryComplete$Query$Order? onCompleteWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onComplete == null
        ? super.properties
        : super.properties.where((property) => property != onComplete),
    onCompleteWithParsed,
  ];
}

class WatchOptions$Query$Order extends graphql.WatchQueryOptions<Query$Order> {
  WatchOptions$Query$Order({
    String? operationName,
    required Variables$Query$Order variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Query$Order? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeQueryOrder,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Query$Order,
       );
}

class FetchMoreOptions$Query$Order extends graphql.FetchMoreOptions {
  FetchMoreOptions$Query$Order({
    required graphql.UpdateQuery updateQuery,
    required Variables$Query$Order variables,
  }) : super(
         updateQuery: updateQuery,
         variables: variables.toJson(),
         document: documentNodeQueryOrder,
       );
}

extension ClientExtension$Query$Order on graphql.GraphQLClient {
  Future<graphql.QueryResult<Query$Order>> query$Order(
    Options$Query$Order options,
  ) async => await this.query(options);

  graphql.ObservableQuery<Query$Order> watchQuery$Order(
    WatchOptions$Query$Order options,
  ) => this.watchQuery(options);

  void writeQuery$Order({
    required Query$Order data,
    required Variables$Query$Order variables,
    bool broadcast = true,
  }) => this.writeQuery(
    graphql.Request(
      operation: graphql.Operation(document: documentNodeQueryOrder),
      variables: variables.toJson(),
    ),
    data: data.toJson(),
    broadcast: broadcast,
  );

  Query$Order? readQuery$Order({
    required Variables$Query$Order variables,
    bool optimistic = true,
  }) {
    final result = this.readQuery(
      graphql.Request(
        operation: graphql.Operation(document: documentNodeQueryOrder),
        variables: variables.toJson(),
      ),
      optimistic: optimistic,
    );
    return result == null ? null : Query$Order.fromJson(result);
  }
}

class Variables$Mutation$CreateOrder {
  factory Variables$Mutation$CreateOrder({
    required String userId,
    required List<Input$OrderItemInput> items,
    required String scheduledAt,
  }) => Variables$Mutation$CreateOrder._({
    r'userId': userId,
    r'items': items,
    r'scheduledAt': scheduledAt,
  });

  Variables$Mutation$CreateOrder._(this._$data);

  factory Variables$Mutation$CreateOrder.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$items = data['items'];
    result$data['items'] = (l$items as List<dynamic>)
        .map((e) => Input$OrderItemInput.fromJson((e as Map<String, dynamic>)))
        .toList();
    final l$scheduledAt = data['scheduledAt'];
    result$data['scheduledAt'] = (l$scheduledAt as String);
    return Variables$Mutation$CreateOrder._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  List<Input$OrderItemInput> get items =>
      (_$data['items'] as List<Input$OrderItemInput>);

  String get scheduledAt => (_$data['scheduledAt'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$items = items;
    result$data['items'] = l$items.map((e) => e.toJson()).toList();
    final l$scheduledAt = scheduledAt;
    result$data['scheduledAt'] = l$scheduledAt;
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateOrder<Variables$Mutation$CreateOrder>
  get copyWith => CopyWith$Variables$Mutation$CreateOrder(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$CreateOrder ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$items = items;
    final lOther$items = other.items;
    if (l$items.length != lOther$items.length) {
      return false;
    }
    for (int i = 0; i < l$items.length; i++) {
      final l$items$entry = l$items[i];
      final lOther$items$entry = lOther$items[i];
      if (l$items$entry != lOther$items$entry) {
        return false;
      }
    }
    final l$scheduledAt = scheduledAt;
    final lOther$scheduledAt = other.scheduledAt;
    if (l$scheduledAt != lOther$scheduledAt) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$items = items;
    final l$scheduledAt = scheduledAt;
    return Object.hashAll([
      l$userId,
      Object.hashAll(l$items.map((v) => v)),
      l$scheduledAt,
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateOrder<TRes> {
  factory CopyWith$Variables$Mutation$CreateOrder(
    Variables$Mutation$CreateOrder instance,
    TRes Function(Variables$Mutation$CreateOrder) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateOrder;

  factory CopyWith$Variables$Mutation$CreateOrder.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateOrder;

  TRes call({
    String? userId,
    List<Input$OrderItemInput>? items,
    String? scheduledAt,
  });
}

class _CopyWithImpl$Variables$Mutation$CreateOrder<TRes>
    implements CopyWith$Variables$Mutation$CreateOrder<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateOrder(this._instance, this._then);

  final Variables$Mutation$CreateOrder _instance;

  final TRes Function(Variables$Mutation$CreateOrder) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userId = _undefined,
    Object? items = _undefined,
    Object? scheduledAt = _undefined,
  }) => _then(
    Variables$Mutation$CreateOrder._({
      ..._instance._$data,
      if (userId != _undefined && userId != null) 'userId': (userId as String),
      if (items != _undefined && items != null)
        'items': (items as List<Input$OrderItemInput>),
      if (scheduledAt != _undefined && scheduledAt != null)
        'scheduledAt': (scheduledAt as String),
    }),
  );
}

class _CopyWithStubImpl$Variables$Mutation$CreateOrder<TRes>
    implements CopyWith$Variables$Mutation$CreateOrder<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateOrder(this._res);

  TRes _res;

  call({
    String? userId,
    List<Input$OrderItemInput>? items,
    String? scheduledAt,
  }) => _res;
}

class Mutation$CreateOrder {
  Mutation$CreateOrder({required this.createOrder});

  factory Mutation$CreateOrder.fromJson(Map<String, dynamic> json) {
    final l$createOrder = json['createOrder'];
    return Mutation$CreateOrder(
      createOrder: Fragment$OrderFields.fromJson(
        (l$createOrder as Map<String, dynamic>),
      ),
    );
  }

  final Fragment$OrderFields createOrder;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createOrder = createOrder;
    _resultData['createOrder'] = l$createOrder.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createOrder = createOrder;
    return Object.hashAll([l$createOrder]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$CreateOrder || runtimeType != other.runtimeType) {
      return false;
    }
    final l$createOrder = createOrder;
    final lOther$createOrder = other.createOrder;
    if (l$createOrder != lOther$createOrder) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$CreateOrder on Mutation$CreateOrder {
  CopyWith$Mutation$CreateOrder<Mutation$CreateOrder> get copyWith =>
      CopyWith$Mutation$CreateOrder(this, (i) => i);
}

abstract class CopyWith$Mutation$CreateOrder<TRes> {
  factory CopyWith$Mutation$CreateOrder(
    Mutation$CreateOrder instance,
    TRes Function(Mutation$CreateOrder) then,
  ) = _CopyWithImpl$Mutation$CreateOrder;

  factory CopyWith$Mutation$CreateOrder.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateOrder;

  TRes call({Fragment$OrderFields? createOrder});
  CopyWith$Fragment$OrderFields<TRes> get createOrder;
}

class _CopyWithImpl$Mutation$CreateOrder<TRes>
    implements CopyWith$Mutation$CreateOrder<TRes> {
  _CopyWithImpl$Mutation$CreateOrder(this._instance, this._then);

  final Mutation$CreateOrder _instance;

  final TRes Function(Mutation$CreateOrder) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? createOrder = _undefined}) => _then(
    Mutation$CreateOrder(
      createOrder: createOrder == _undefined || createOrder == null
          ? _instance.createOrder
          : (createOrder as Fragment$OrderFields),
    ),
  );

  CopyWith$Fragment$OrderFields<TRes> get createOrder {
    final local$createOrder = _instance.createOrder;
    return CopyWith$Fragment$OrderFields(
      local$createOrder,
      (e) => call(createOrder: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$CreateOrder<TRes>
    implements CopyWith$Mutation$CreateOrder<TRes> {
  _CopyWithStubImpl$Mutation$CreateOrder(this._res);

  TRes _res;

  call({Fragment$OrderFields? createOrder}) => _res;

  CopyWith$Fragment$OrderFields<TRes> get createOrder =>
      CopyWith$Fragment$OrderFields.stub(_res);
}

const documentNodeMutationCreateOrder = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'CreateOrder'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'userId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'items')),
          type: ListTypeNode(
            type: NamedTypeNode(
              name: NameNode(value: 'OrderItemInput'),
              isNonNull: true,
            ),
            isNonNull: true,
          ),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'scheduledAt')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'createOrder'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'userId'),
                value: VariableNode(name: NameNode(value: 'userId')),
              ),
              ArgumentNode(
                name: NameNode(value: 'items'),
                value: VariableNode(name: NameNode(value: 'items')),
              ),
              ArgumentNode(
                name: NameNode(value: 'scheduledAt'),
                value: VariableNode(name: NameNode(value: 'scheduledAt')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'OrderFields'),
                  directives: [],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    fragmentDefinitionOrderFields,
  ],
);
Mutation$CreateOrder _parserFn$Mutation$CreateOrder(
  Map<String, dynamic> data,
) => Mutation$CreateOrder.fromJson(data);
typedef OnMutationCompleted$Mutation$CreateOrder = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$CreateOrder?,
);

class Options$Mutation$CreateOrder
    extends graphql.MutationOptions<Mutation$CreateOrder> {
  Options$Mutation$CreateOrder({
    String? operationName,
    required Variables$Mutation$CreateOrder variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateOrder? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$CreateOrder? onCompleted,
    graphql.OnMutationUpdate<Mutation$CreateOrder>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFn$Mutation$CreateOrder(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationCreateOrder,
         parserFn: _parserFn$Mutation$CreateOrder,
       );

  final OnMutationCompleted$Mutation$CreateOrder? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$CreateOrder
    extends graphql.WatchQueryOptions<Mutation$CreateOrder> {
  WatchOptions$Mutation$CreateOrder({
    String? operationName,
    required Variables$Mutation$CreateOrder variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$CreateOrder? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationCreateOrder,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$CreateOrder,
       );
}

extension ClientExtension$Mutation$CreateOrder on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$CreateOrder>> mutate$CreateOrder(
    Options$Mutation$CreateOrder options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<Mutation$CreateOrder> watchMutation$CreateOrder(
    WatchOptions$Mutation$CreateOrder options,
  ) => this.watchMutation(options);
}

class Variables$Mutation$PayOrder {
  factory Variables$Mutation$PayOrder({
    required String orderId,
    required String cardToken,
  }) => Variables$Mutation$PayOrder._({
    r'orderId': orderId,
    r'cardToken': cardToken,
  });

  Variables$Mutation$PayOrder._(this._$data);

  factory Variables$Mutation$PayOrder.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$orderId = data['orderId'];
    result$data['orderId'] = (l$orderId as String);
    final l$cardToken = data['cardToken'];
    result$data['cardToken'] = (l$cardToken as String);
    return Variables$Mutation$PayOrder._(result$data);
  }

  Map<String, dynamic> _$data;

  String get orderId => (_$data['orderId'] as String);

  String get cardToken => (_$data['cardToken'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$orderId = orderId;
    result$data['orderId'] = l$orderId;
    final l$cardToken = cardToken;
    result$data['cardToken'] = l$cardToken;
    return result$data;
  }

  CopyWith$Variables$Mutation$PayOrder<Variables$Mutation$PayOrder>
  get copyWith => CopyWith$Variables$Mutation$PayOrder(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Variables$Mutation$PayOrder ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$orderId = orderId;
    final lOther$orderId = other.orderId;
    if (l$orderId != lOther$orderId) {
      return false;
    }
    final l$cardToken = cardToken;
    final lOther$cardToken = other.cardToken;
    if (l$cardToken != lOther$cardToken) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$orderId = orderId;
    final l$cardToken = cardToken;
    return Object.hashAll([l$orderId, l$cardToken]);
  }
}

abstract class CopyWith$Variables$Mutation$PayOrder<TRes> {
  factory CopyWith$Variables$Mutation$PayOrder(
    Variables$Mutation$PayOrder instance,
    TRes Function(Variables$Mutation$PayOrder) then,
  ) = _CopyWithImpl$Variables$Mutation$PayOrder;

  factory CopyWith$Variables$Mutation$PayOrder.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$PayOrder;

  TRes call({String? orderId, String? cardToken});
}

class _CopyWithImpl$Variables$Mutation$PayOrder<TRes>
    implements CopyWith$Variables$Mutation$PayOrder<TRes> {
  _CopyWithImpl$Variables$Mutation$PayOrder(this._instance, this._then);

  final Variables$Mutation$PayOrder _instance;

  final TRes Function(Variables$Mutation$PayOrder) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? orderId = _undefined, Object? cardToken = _undefined}) =>
      _then(
        Variables$Mutation$PayOrder._({
          ..._instance._$data,
          if (orderId != _undefined && orderId != null)
            'orderId': (orderId as String),
          if (cardToken != _undefined && cardToken != null)
            'cardToken': (cardToken as String),
        }),
      );
}

class _CopyWithStubImpl$Variables$Mutation$PayOrder<TRes>
    implements CopyWith$Variables$Mutation$PayOrder<TRes> {
  _CopyWithStubImpl$Variables$Mutation$PayOrder(this._res);

  TRes _res;

  call({String? orderId, String? cardToken}) => _res;
}

class Mutation$PayOrder {
  Mutation$PayOrder({required this.payOrder});

  factory Mutation$PayOrder.fromJson(Map<String, dynamic> json) {
    final l$payOrder = json['payOrder'];
    return Mutation$PayOrder(
      payOrder: Fragment$OrderFields.fromJson(
        (l$payOrder as Map<String, dynamic>),
      ),
    );
  }

  final Fragment$OrderFields payOrder;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$payOrder = payOrder;
    _resultData['payOrder'] = l$payOrder.toJson();
    return _resultData;
  }

  @override
  int get hashCode {
    final l$payOrder = payOrder;
    return Object.hashAll([l$payOrder]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Mutation$PayOrder || runtimeType != other.runtimeType) {
      return false;
    }
    final l$payOrder = payOrder;
    final lOther$payOrder = other.payOrder;
    if (l$payOrder != lOther$payOrder) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$PayOrder on Mutation$PayOrder {
  CopyWith$Mutation$PayOrder<Mutation$PayOrder> get copyWith =>
      CopyWith$Mutation$PayOrder(this, (i) => i);
}

abstract class CopyWith$Mutation$PayOrder<TRes> {
  factory CopyWith$Mutation$PayOrder(
    Mutation$PayOrder instance,
    TRes Function(Mutation$PayOrder) then,
  ) = _CopyWithImpl$Mutation$PayOrder;

  factory CopyWith$Mutation$PayOrder.stub(TRes res) =
      _CopyWithStubImpl$Mutation$PayOrder;

  TRes call({Fragment$OrderFields? payOrder});
  CopyWith$Fragment$OrderFields<TRes> get payOrder;
}

class _CopyWithImpl$Mutation$PayOrder<TRes>
    implements CopyWith$Mutation$PayOrder<TRes> {
  _CopyWithImpl$Mutation$PayOrder(this._instance, this._then);

  final Mutation$PayOrder _instance;

  final TRes Function(Mutation$PayOrder) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? payOrder = _undefined}) => _then(
    Mutation$PayOrder(
      payOrder: payOrder == _undefined || payOrder == null
          ? _instance.payOrder
          : (payOrder as Fragment$OrderFields),
    ),
  );

  CopyWith$Fragment$OrderFields<TRes> get payOrder {
    final local$payOrder = _instance.payOrder;
    return CopyWith$Fragment$OrderFields(
      local$payOrder,
      (e) => call(payOrder: e),
    );
  }
}

class _CopyWithStubImpl$Mutation$PayOrder<TRes>
    implements CopyWith$Mutation$PayOrder<TRes> {
  _CopyWithStubImpl$Mutation$PayOrder(this._res);

  TRes _res;

  call({Fragment$OrderFields? payOrder}) => _res;

  CopyWith$Fragment$OrderFields<TRes> get payOrder =>
      CopyWith$Fragment$OrderFields.stub(_res);
}

const documentNodeMutationPayOrder = DocumentNode(
  definitions: [
    OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'PayOrder'),
      variableDefinitions: [
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'orderId')),
          type: NamedTypeNode(name: NameNode(value: 'ID'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
        VariableDefinitionNode(
          variable: VariableNode(name: NameNode(value: 'cardToken')),
          type: NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
          defaultValue: DefaultValueNode(value: null),
          directives: [],
        ),
      ],
      directives: [],
      selectionSet: SelectionSetNode(
        selections: [
          FieldNode(
            name: NameNode(value: 'payOrder'),
            alias: null,
            arguments: [
              ArgumentNode(
                name: NameNode(value: 'orderId'),
                value: VariableNode(name: NameNode(value: 'orderId')),
              ),
              ArgumentNode(
                name: NameNode(value: 'cardToken'),
                value: VariableNode(name: NameNode(value: 'cardToken')),
              ),
            ],
            directives: [],
            selectionSet: SelectionSetNode(
              selections: [
                FragmentSpreadNode(
                  name: NameNode(value: 'OrderFields'),
                  directives: [],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    fragmentDefinitionOrderFields,
  ],
);
Mutation$PayOrder _parserFn$Mutation$PayOrder(Map<String, dynamic> data) =>
    Mutation$PayOrder.fromJson(data);
typedef OnMutationCompleted$Mutation$PayOrder = FutureOr<void> Function(
  Map<String, dynamic>?,
  Mutation$PayOrder?,
);

class Options$Mutation$PayOrder
    extends graphql.MutationOptions<Mutation$PayOrder> {
  Options$Mutation$PayOrder({
    String? operationName,
    required Variables$Mutation$PayOrder variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$PayOrder? typedOptimisticResult,
    graphql.Context? context,
    OnMutationCompleted$Mutation$PayOrder? onCompleted,
    graphql.OnMutationUpdate<Mutation$PayOrder>? update,
    graphql.OnError? onError,
  }) : onCompletedWithParsed = onCompleted,
       super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         onCompleted: onCompleted == null
             ? null
             : (data) => onCompleted(
                 data,
                 data == null ? null : _parserFn$Mutation$PayOrder(data),
               ),
         update: update,
         onError: onError,
         document: documentNodeMutationPayOrder,
         parserFn: _parserFn$Mutation$PayOrder,
       );

  final OnMutationCompleted$Mutation$PayOrder? onCompletedWithParsed;

  @override
  List<Object?> get properties => [
    ...super.onCompleted == null
        ? super.properties
        : super.properties.where((property) => property != onCompleted),
    onCompletedWithParsed,
  ];
}

class WatchOptions$Mutation$PayOrder
    extends graphql.WatchQueryOptions<Mutation$PayOrder> {
  WatchOptions$Mutation$PayOrder({
    String? operationName,
    required Variables$Mutation$PayOrder variables,
    graphql.FetchPolicy? fetchPolicy,
    graphql.ErrorPolicy? errorPolicy,
    graphql.CacheRereadPolicy? cacheRereadPolicy,
    Object? optimisticResult,
    Mutation$PayOrder? typedOptimisticResult,
    graphql.Context? context,
    Duration? pollInterval,
    bool? eagerlyFetchResults,
    bool carryForwardDataOnException = true,
    bool fetchResults = false,
  }) : super(
         variables: variables.toJson(),
         operationName: operationName,
         fetchPolicy: fetchPolicy,
         errorPolicy: errorPolicy,
         cacheRereadPolicy: cacheRereadPolicy,
         optimisticResult: optimisticResult ?? typedOptimisticResult?.toJson(),
         context: context,
         document: documentNodeMutationPayOrder,
         pollInterval: pollInterval,
         eagerlyFetchResults: eagerlyFetchResults,
         carryForwardDataOnException: carryForwardDataOnException,
         fetchResults: fetchResults,
         parserFn: _parserFn$Mutation$PayOrder,
       );
}

extension ClientExtension$Mutation$PayOrder on graphql.GraphQLClient {
  Future<graphql.QueryResult<Mutation$PayOrder>> mutate$PayOrder(
    Options$Mutation$PayOrder options,
  ) async => await this.mutate(options);

  graphql.ObservableQuery<Mutation$PayOrder> watchMutation$PayOrder(
    WatchOptions$Mutation$PayOrder options,
  ) => this.watchMutation(options);
}

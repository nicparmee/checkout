class Input$OrderItemInput {
  factory Input$OrderItemInput({
    required String productId,
    required int quantity,
  }) =>
      Input$OrderItemInput._({r'productId': productId, r'quantity': quantity});

  Input$OrderItemInput._(this._$data);

  factory Input$OrderItemInput.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$productId = data['productId'];
    result$data['productId'] = (l$productId as String);
    final l$quantity = data['quantity'];
    result$data['quantity'] = (l$quantity as int);
    return Input$OrderItemInput._(result$data);
  }

  Map<String, dynamic> _$data;

  String get productId => (_$data['productId'] as String);

  int get quantity => (_$data['quantity'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$productId = productId;
    result$data['productId'] = l$productId;
    final l$quantity = quantity;
    result$data['quantity'] = l$quantity;
    return result$data;
  }

  CopyWith$Input$OrderItemInput<Input$OrderItemInput> get copyWith =>
      CopyWith$Input$OrderItemInput(this, (i) => i);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other is! Input$OrderItemInput || runtimeType != other.runtimeType) {
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

  @override
  int get hashCode {
    final l$productId = productId;
    final l$quantity = quantity;
    return Object.hashAll([l$productId, l$quantity]);
  }
}

abstract class CopyWith$Input$OrderItemInput<TRes> {
  factory CopyWith$Input$OrderItemInput(
    Input$OrderItemInput instance,
    TRes Function(Input$OrderItemInput) then,
  ) = _CopyWithImpl$Input$OrderItemInput;

  factory CopyWith$Input$OrderItemInput.stub(TRes res) =
      _CopyWithStubImpl$Input$OrderItemInput;

  TRes call({String? productId, int? quantity});
}

class _CopyWithImpl$Input$OrderItemInput<TRes>
    implements CopyWith$Input$OrderItemInput<TRes> {
  _CopyWithImpl$Input$OrderItemInput(this._instance, this._then);

  final Input$OrderItemInput _instance;

  final TRes Function(Input$OrderItemInput) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? productId = _undefined, Object? quantity = _undefined}) =>
      _then(
        Input$OrderItemInput._({
          ..._instance._$data,
          if (productId != _undefined && productId != null)
            'productId': (productId as String),
          if (quantity != _undefined && quantity != null)
            'quantity': (quantity as int),
        }),
      );
}

class _CopyWithStubImpl$Input$OrderItemInput<TRes>
    implements CopyWith$Input$OrderItemInput<TRes> {
  _CopyWithStubImpl$Input$OrderItemInput(this._res);

  TRes _res;

  call({String? productId, int? quantity}) => _res;
}

enum Enum$OrderStatus {
  PENDING,
  PROCESSING,
  PAID,
  FAILED,
  EXPIRED,
  $unknown;

  factory Enum$OrderStatus.fromJson(String value) =>
      fromJson$Enum$OrderStatus(value);

  String toJson() => toJson$Enum$OrderStatus(this);
}

String toJson$Enum$OrderStatus(Enum$OrderStatus e) {
  switch (e) {
    case Enum$OrderStatus.PENDING:
      return r'PENDING';
    case Enum$OrderStatus.PROCESSING:
      return r'PROCESSING';
    case Enum$OrderStatus.PAID:
      return r'PAID';
    case Enum$OrderStatus.FAILED:
      return r'FAILED';
    case Enum$OrderStatus.EXPIRED:
      return r'EXPIRED';
    case Enum$OrderStatus.$unknown:
      return r'$unknown';
  }
}

Enum$OrderStatus fromJson$Enum$OrderStatus(String value) {
  switch (value) {
    case r'PENDING':
      return Enum$OrderStatus.PENDING;
    case r'PROCESSING':
      return Enum$OrderStatus.PROCESSING;
    case r'PAID':
      return Enum$OrderStatus.PAID;
    case r'FAILED':
      return Enum$OrderStatus.FAILED;
    case r'EXPIRED':
      return Enum$OrderStatus.EXPIRED;
    default:
      return Enum$OrderStatus.$unknown;
  }
}

enum Enum$__TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL,
  $unknown;

  factory Enum$__TypeKind.fromJson(String value) =>
      fromJson$Enum$__TypeKind(value);

  String toJson() => toJson$Enum$__TypeKind(this);
}

String toJson$Enum$__TypeKind(Enum$__TypeKind e) {
  switch (e) {
    case Enum$__TypeKind.SCALAR:
      return r'SCALAR';
    case Enum$__TypeKind.OBJECT:
      return r'OBJECT';
    case Enum$__TypeKind.INTERFACE:
      return r'INTERFACE';
    case Enum$__TypeKind.UNION:
      return r'UNION';
    case Enum$__TypeKind.ENUM:
      return r'ENUM';
    case Enum$__TypeKind.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__TypeKind.LIST:
      return r'LIST';
    case Enum$__TypeKind.NON_NULL:
      return r'NON_NULL';
    case Enum$__TypeKind.$unknown:
      return r'$unknown';
  }
}

Enum$__TypeKind fromJson$Enum$__TypeKind(String value) {
  switch (value) {
    case r'SCALAR':
      return Enum$__TypeKind.SCALAR;
    case r'OBJECT':
      return Enum$__TypeKind.OBJECT;
    case r'INTERFACE':
      return Enum$__TypeKind.INTERFACE;
    case r'UNION':
      return Enum$__TypeKind.UNION;
    case r'ENUM':
      return Enum$__TypeKind.ENUM;
    case r'INPUT_OBJECT':
      return Enum$__TypeKind.INPUT_OBJECT;
    case r'LIST':
      return Enum$__TypeKind.LIST;
    case r'NON_NULL':
      return Enum$__TypeKind.NON_NULL;
    default:
      return Enum$__TypeKind.$unknown;
  }
}

enum Enum$__DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
  $unknown;

  factory Enum$__DirectiveLocation.fromJson(String value) =>
      fromJson$Enum$__DirectiveLocation(value);

  String toJson() => toJson$Enum$__DirectiveLocation(this);
}

String toJson$Enum$__DirectiveLocation(Enum$__DirectiveLocation e) {
  switch (e) {
    case Enum$__DirectiveLocation.QUERY:
      return r'QUERY';
    case Enum$__DirectiveLocation.MUTATION:
      return r'MUTATION';
    case Enum$__DirectiveLocation.SUBSCRIPTION:
      return r'SUBSCRIPTION';
    case Enum$__DirectiveLocation.FIELD:
      return r'FIELD';
    case Enum$__DirectiveLocation.FRAGMENT_DEFINITION:
      return r'FRAGMENT_DEFINITION';
    case Enum$__DirectiveLocation.FRAGMENT_SPREAD:
      return r'FRAGMENT_SPREAD';
    case Enum$__DirectiveLocation.INLINE_FRAGMENT:
      return r'INLINE_FRAGMENT';
    case Enum$__DirectiveLocation.VARIABLE_DEFINITION:
      return r'VARIABLE_DEFINITION';
    case Enum$__DirectiveLocation.SCHEMA:
      return r'SCHEMA';
    case Enum$__DirectiveLocation.SCALAR:
      return r'SCALAR';
    case Enum$__DirectiveLocation.OBJECT:
      return r'OBJECT';
    case Enum$__DirectiveLocation.FIELD_DEFINITION:
      return r'FIELD_DEFINITION';
    case Enum$__DirectiveLocation.ARGUMENT_DEFINITION:
      return r'ARGUMENT_DEFINITION';
    case Enum$__DirectiveLocation.INTERFACE:
      return r'INTERFACE';
    case Enum$__DirectiveLocation.UNION:
      return r'UNION';
    case Enum$__DirectiveLocation.ENUM:
      return r'ENUM';
    case Enum$__DirectiveLocation.ENUM_VALUE:
      return r'ENUM_VALUE';
    case Enum$__DirectiveLocation.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION:
      return r'INPUT_FIELD_DEFINITION';
    case Enum$__DirectiveLocation.$unknown:
      return r'$unknown';
  }
}

Enum$__DirectiveLocation fromJson$Enum$__DirectiveLocation(String value) {
  switch (value) {
    case r'QUERY':
      return Enum$__DirectiveLocation.QUERY;
    case r'MUTATION':
      return Enum$__DirectiveLocation.MUTATION;
    case r'SUBSCRIPTION':
      return Enum$__DirectiveLocation.SUBSCRIPTION;
    case r'FIELD':
      return Enum$__DirectiveLocation.FIELD;
    case r'FRAGMENT_DEFINITION':
      return Enum$__DirectiveLocation.FRAGMENT_DEFINITION;
    case r'FRAGMENT_SPREAD':
      return Enum$__DirectiveLocation.FRAGMENT_SPREAD;
    case r'INLINE_FRAGMENT':
      return Enum$__DirectiveLocation.INLINE_FRAGMENT;
    case r'VARIABLE_DEFINITION':
      return Enum$__DirectiveLocation.VARIABLE_DEFINITION;
    case r'SCHEMA':
      return Enum$__DirectiveLocation.SCHEMA;
    case r'SCALAR':
      return Enum$__DirectiveLocation.SCALAR;
    case r'OBJECT':
      return Enum$__DirectiveLocation.OBJECT;
    case r'FIELD_DEFINITION':
      return Enum$__DirectiveLocation.FIELD_DEFINITION;
    case r'ARGUMENT_DEFINITION':
      return Enum$__DirectiveLocation.ARGUMENT_DEFINITION;
    case r'INTERFACE':
      return Enum$__DirectiveLocation.INTERFACE;
    case r'UNION':
      return Enum$__DirectiveLocation.UNION;
    case r'ENUM':
      return Enum$__DirectiveLocation.ENUM;
    case r'ENUM_VALUE':
      return Enum$__DirectiveLocation.ENUM_VALUE;
    case r'INPUT_OBJECT':
      return Enum$__DirectiveLocation.INPUT_OBJECT;
    case r'INPUT_FIELD_DEFINITION':
      return Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION;
    default:
      return Enum$__DirectiveLocation.$unknown;
  }
}

const possibleTypesMap = <String, Set<String>>{};

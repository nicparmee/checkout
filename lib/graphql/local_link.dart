import 'package:graphql/client.dart';
import 'package:gql/ast.dart';

/// Resolves GraphQL operations in-app instead of over HTTP.
/// Swap for HttpLink (or Link.split) when a real server exists.
class LocalLink extends Link {
  // ponytail: returns whole objects regardless of the selected fields;
  // fine while queries ask for everything, add field filtering if that changes.
  final _resolvers =
      <String, Map<String, dynamic> Function(Map<String, dynamic>)>{
        'Products': (_) => {'products': _products},
      };

  @override
  Stream<Response> request(Request request, [NextLink? forward]) async* {
    final name = request.operation.document.definitions
        .whereType<OperationDefinitionNode>()
        .first
        .name
        ?.value;
    final resolver = _resolvers[name];
    yield resolver == null
        ? Response(
            errors: [GraphQLError(message: 'No local resolver for $name')],
            response: const {},
          )
        : Response(data: resolver(request.variables), response: const {});
  }
}

const _products = [
  {
    'id': '1',
    'name': 'Classic Tee',
    'description': 'Soft cotton t-shirt in a relaxed fit.',
    'imageUrl': 'https://picsum.photos/seed/tee/400/300',
  },
  {
    'id': '2',
    'name': 'Canvas Tote',
    'description': 'Sturdy everyday bag with an inner pocket.',
    'imageUrl': 'https://picsum.photos/seed/tote/400/300',
  },
  {
    'id': '3',
    'name': 'Ceramic Mug',
    'description': 'Holds 350ml. Dishwasher and microwave safe.',
    'imageUrl': 'https://picsum.photos/seed/mug/400/300',
  },
];

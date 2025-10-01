import 'package:graph_ql_demos/models/character_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RickAndMortyService {
  final String url = "https://rickandmortyapi.com/graphql";

  final String allQuery = """
    query GetAllCharacters(\$page: Int) {
      characters(page: \$page) {
        info {
          count
          pages
          next
          prev
        }
        results {
          id
          name
          status
          species
          type
          gender
          image
          created
        }
      }
    }
  """;

  Future<List<CharacterModel>> fetchCharacters({int page = 1}) async {
    try {
      final HttpLink httpLink = HttpLink(url);

      final GraphQLClient client = GraphQLClient(
        cache: GraphQLCache(store: InMemoryStore()),
        link: httpLink,
      );

      final QueryOptions options = QueryOptions(
        document: gql(allQuery),
        variables: {"page": page},
      );

      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw Exception(result.exception.toString());
      }

      final data = result.data?['characters'];
      final List results = data['results'];

      return results.map((e) => CharacterModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}

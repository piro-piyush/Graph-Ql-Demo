import 'package:graph_ql_demos/models/country_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountryService {
  final url = 'https://countries.trevorblades.com/graphql';
  final query = """
  query GetAllCountries {
  countries {
    code
    name
    native
    capital
    emoji
    emojiU
    currency 
    currency
    languages {
      code
      name
      native
      rtl
    }
  }
}
  """;

  Future<List<CountryModel>> getCountries() async {
    try {
      final HttpLink httpLink = HttpLink(url);
      final GraphQLClient client = GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(store: InMemoryStore()),
      );
      final QueryOptions options = QueryOptions(document: gql(query));
      final QueryResult result = await client.query(options);
      if (result.hasException) {
        throw Exception(result.exception.toString());
      }
      print(result.data);
      final List<dynamic> data = result.data?['countries'] ?? [];
      print(data.toString());
      return data.map((d) => CountryModel.fromJson(d as Map<String, dynamic>)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}

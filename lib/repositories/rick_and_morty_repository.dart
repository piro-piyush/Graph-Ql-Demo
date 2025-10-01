import 'package:graph_ql_demos/models/character_model.dart';
import 'package:graph_ql_demos/services/rick_and_morty_service.dart';

class RickAndMortyRepository {
  final RickAndMortyService _service = RickAndMortyService();

  int _currentPage = 1;
  bool _hasNextPage = true;

  /// Fetch characters for a specific page
  Future<List<CharacterModel>> getCharacters({int page = 1}) async {
    try {
      final characters = await _service.fetchCharacters(page: page);
      return characters;
    } catch (e) {
      throw Exception("Failed to fetch characters: $e");
    }
  }

  /// Initial load
  Future<List<CharacterModel>> loadInitialCharacters() async {
    _currentPage = 1;
    _hasNextPage = true;

    final characters = await getCharacters(page: _currentPage);

    // check if less than 20 results => no more pages
    if (characters.length < 20) _hasNextPage = false;

    return characters;
  }

  /// Load more (next page)
  Future<List<CharacterModel>> loadMoreCharacters() async {
    if (!_hasNextPage) return [];

    _currentPage++;
    final characters = await getCharacters(page: _currentPage);

    if (characters.length < 20) _hasNextPage = false;

    return characters;
  }

  /// Check if more pages exist
  bool get hasMorePages => _hasNextPage;
}

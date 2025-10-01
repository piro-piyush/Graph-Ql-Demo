import 'package:flutter/material.dart';
import 'package:graph_ql_demos/models/character_model.dart';
import 'package:graph_ql_demos/repositories/rick_and_morty_repository.dart';

class RickAndMortyScreen extends StatefulWidget {
  const RickAndMortyScreen({super.key});

  @override
  State<RickAndMortyScreen> createState() => _RickAndMortyScreenState();
}

class _RickAndMortyScreenState extends State<RickAndMortyScreen> {
  final RickAndMortyRepository repository = RickAndMortyRepository();
  final ScrollController _scrollController = ScrollController();

  List<CharacterModel> characters = [];
  bool isLoading = false;
  bool hasMore = true;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    _fetchCharacters();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          hasMore) {
        _fetchCharacters();
      }
    });
  }

  Future<void> _fetchCharacters() async {
    setState(() => isLoading = true);

    try {
      final newCharacters = await repository.getCharacters(page: currentPage);
      setState(() {
        currentPage++;
        characters.addAll(newCharacters);
        if (newCharacters.isEmpty) hasMore = false;
      });
    } catch (e) {
      // optionally show error
      print("Error fetching characters: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rick And Morty"),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: characters.length + (hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < characters.length) {
            final character = characters[index];
            return ListTile(
              leading:
              Image.network(character.image, width: 50, height: 50),
              title: Text(character.name),
              subtitle: Text("${character.species} - ${character.status}"),
            );
          } else {
            // loading indicator at bottom
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}

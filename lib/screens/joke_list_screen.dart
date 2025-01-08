import 'package:flutter/material.dart';
import 'package:joke_app/models/joke_model.dart';
import 'package:joke_app/services/api_service.dart';
import 'package:joke_app/screens/favorites_screen.dart';

class JokeListScreen extends StatefulWidget {
  final String jokeType;
  const JokeListScreen({required this.jokeType, super.key});

  @override
  JokeListScreenState createState() => JokeListScreenState();
}

class JokeListScreenState extends State<JokeListScreen> {
  List<Joke> jokes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJokes();
  }

  Future<void> fetchJokes() async {
    try {
      final fetchedJokes = await ApiService.fetchJokes(widget.jokeType);

      if (!mounted) return;

      setState(() {
        jokes = fetchedJokes;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  void toggleFavorite(Joke joke) {
    setState(() {
      joke.isFavorite = !joke.isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Joke> favoriteJokes = jokes.where((joke) => joke.isFavorite).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.jokeType.capitalize()} Jokes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesScreen(
                    jokes: favoriteJokes,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : jokes.isEmpty
              ? const Center(child: Text('No jokes found.'))
              : ListView.builder(
                  itemCount: jokes.length,
                  itemBuilder: (context, index) {
                    final joke = jokes[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        title: Text(
                          joke.setup,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(joke.punchline),
                        trailing: IconButton(
                          icon: Icon(
                            joke.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: joke.isFavorite ? Colors.red : Colors.grey,
                          ),
                          onPressed: () => toggleFavorite(joke),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

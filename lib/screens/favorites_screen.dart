import 'package:flutter/material.dart';
import 'package:joke_app/models/joke_model.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Joke> jokes;

  const FavoritesScreen({required this.jokes, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Jokes'),
        backgroundColor: Colors.deepPurple,
      ),
      body: jokes.isEmpty
          ? const Center(
              child: Text(
                'No favorite jokes yet!',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: jokes.length,
              itemBuilder: (context, index) {
                final joke = jokes[index];
                return Card(
                  elevation: 4,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListTile(
                      title: Text(
                        joke.setup,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      subtitle: Text(
                        joke.punchline,
                        style: const TextStyle(
                            fontSize: 16, color: Colors.black54),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

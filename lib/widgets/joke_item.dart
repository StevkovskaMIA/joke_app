import 'package:flutter/material.dart';
import 'package:joke_app/models/joke_model.dart';

class JokeCard extends StatelessWidget {
  final Joke joke;

  const JokeCard({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          joke.setup,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(joke.punchline),
      ),
    );
  }
}

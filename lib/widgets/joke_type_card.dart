import 'package:flutter/material.dart';

class JokeTypeCard extends StatelessWidget {
  final String jokeType;
  final VoidCallback onTap;

  const JokeTypeCard({super.key, required this.jokeType, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(jokeType),
        onTap: onTap,
      ),
    );
  }
}

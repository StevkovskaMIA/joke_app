import 'package:flutter/material.dart';
import 'package:joke_app/models/joke_model.dart';
import 'package:joke_app/services/api_service.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({super.key});

  @override
  RandomJokeScreenState createState() => RandomJokeScreenState();
}

class RandomJokeScreenState extends State<RandomJokeScreen> {
  Joke? randomJoke;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchRandomJoke();
  }

  Future<void> fetchRandomJoke() async {
    try {
      final fetchedJoke = await ApiService.fetchRandomJoke();

      if (!mounted) return;

      setState(() {
        randomJoke = fetchedJoke;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke of the Day'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : randomJoke == null
              ? const Center(
                  child: Text('Failed to load a joke.'),
                )
              : Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          randomJoke!.setup,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          randomJoke!.punchline,
                          style: const TextStyle(fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}

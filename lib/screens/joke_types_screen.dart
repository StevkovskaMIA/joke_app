import 'package:flutter/material.dart';
import 'package:joke_app/screens/joke_list_screen.dart';
import 'package:joke_app/services/api_service.dart';
import 'package:joke_app/screens/random_joke_screen.dart';

class JokeTypesScreen extends StatefulWidget {
  const JokeTypesScreen({super.key});

  @override
  JokeTypesScreenState createState() => JokeTypesScreenState();
}

class JokeTypesScreenState extends State<JokeTypesScreen> {
  List<String> jokeTypes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJokeTypes();
  }

  Future<void> fetchJokeTypes() async {
    try {
      final types = await ApiService.fetchJokeTypes();

      if (!mounted) return;

      setState(() {
        jokeTypes = types;
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
        title: const Text('Joke Types'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RandomJokeScreen()),
              );
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : jokeTypes.isEmpty
              ? const Center(
                  child: Text('No joke types found.'),
                )
              : ListView.builder(
                  itemCount: jokeTypes.length,
                  itemBuilder: (context, index) {
                    final jokeType = jokeTypes[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          jokeType,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  JokeListScreen(jokeType: jokeType),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}

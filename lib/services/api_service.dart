import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:joke_app/models/joke_model.dart';

class ApiService {
  static Future<List<String>> fetchJokeTypes() async {
    final response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/types'));

    if (response.statusCode == 200) {
      return List<String>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to load joke types');
    }
  }

  static Future<List<Joke>> fetchJokes(String type) async {
    final response = await http.get(
        Uri.parse('https://official-joke-api.appspot.com/jokes/$type/ten'));

    if (response.statusCode == 200) {
      var jokes = json.decode(response.body) as List;
      return jokes.map((jokeJson) => Joke.fromJson(jokeJson)).toList();
    } else {
      throw Exception('Failed to load jokes');
    }
  }

  static Future<Joke> fetchRandomJoke() async {
    final response = await http
        .get(Uri.parse('https://official-joke-api.appspot.com/random_joke'));

    if (response.statusCode == 200) {
      return Joke.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load random joke');
    }
  }
}

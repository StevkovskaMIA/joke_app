class Joke {
  final String setup;
  final String punchline;
  bool isFavorite;

  Joke({
    required this.setup,
    required this.punchline,
    this.isFavorite = false,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      setup: json['setup'] ?? '',
      punchline: json['punchline'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
  }
}

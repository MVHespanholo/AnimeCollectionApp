class Anime {
  int? id;
  String title;
  String genre;
  int episodes;
  String status;
  double rating;
  String description;
  String imageUrl;
  String studio;

  Anime({
    this.id,
    required this.title,
    required this.genre,
    required this.episodes,
    required this.status,
    required this.rating,
    required this.description,
    required this.imageUrl,
    required this.studio,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'episodes': episodes,
      'status': status,
      'rating': rating,
      'description': description,
      'imageUrl': imageUrl,
      'studio': studio,
    };
  }

  factory Anime.fromMap(Map<String, dynamic> map) {
    return Anime(
      id: map['id'],
      title: map['title'],
      genre: map['genre'],
      episodes: map['episodes'],
      status: map['status'],
      rating: map['rating'],
      description: map['description'],
      imageUrl: map['imageUrl'],
      studio: map['studio'],
    );
  }
}

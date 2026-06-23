class Movie {

  final String title;
  final String year;
  final String poster;
  final String imdbID;

  final String plot;
  final String imdbRating;
  final String genre;
  final String director;

  Movie({
    required this.title,
    required this.year,
    required this.poster,
    required this.imdbID,
    required this.plot,
    required this.imdbRating,
    required this.genre,
    required this.director,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {

    return Movie(

      title: json['Title'] ?? '',
      year: json['Year'] ?? '',
      poster: json['Poster'] ?? '',
      imdbID: json['imdbID'] ?? '',

      plot: json['Plot'] ?? '',
      imdbRating: json['imdbRating'] ?? '',
      genre: json['Genre'] ?? '',
      director: json['Director'] ?? '',
    );
  }
}
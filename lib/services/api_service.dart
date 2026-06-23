import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/movie.dart';

class ApiService {

  final String apiKey = 'ea90b8';

   Future<List<Movie>> searchMovies(String movieName) async {

    final url =
        'https://www.omdbapi.com/?apikey=$apiKey&s=$movieName';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      if (data['Search'] != null) {

        List moviesJson = data['Search'];

        List<Movie> movies = [];

        for (var movie in moviesJson) {

          final detailedMovie =
              await getMovieDetails(movie['imdbID']);

          movies.add(detailedMovie);
        }

        return movies;
      }

      return [];

    } else {

      throw Exception('Erro ao carregar filmes');
    }
  }

  Future<Movie> getMovieDetails(String imdbID) async {

    final url =
        'https://www.omdbapi.com/?apikey=$apiKey&i=$imdbID&plot=full';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {

      final data = jsonDecode(response.body);

      return Movie.fromJson(data);

    } else {

      throw Exception('Erro ao carregar detalhes');
    }
  }
}
import 'package:flutter/material.dart';

import '../services/favorites_service.dart';
import '../services/search_service.dart';

class ReportsPage extends StatefulWidget {

  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() =>
      _ReportsPageState();
}

class _ReportsPageState
    extends State<ReportsPage> {

  String selectedGenre = 'Todos';

  List<String> getGenres() {

    List<String> genres = ['Todos'];

    for (var movie
        in FavoritesService.favoriteMovies) {

      if (!genres.contains(movie.genre)) {

        genres.add(movie.genre);
      }
    }

    return genres;
  }

  Map<String, int> countGenres() {

    Map<String, int> genreCount = {};

    for (var movie
        in FavoritesService.favoriteMovies) {

      genreCount[movie.genre] =
          (genreCount[movie.genre] ?? 0) + 1;
    }

    return genreCount;
  }

  String getFavoriteGenre() {

    final genres = countGenres();

    if (genres.isEmpty) {
      return 'Nenhum';
    }

    String favoriteGenre =
        genres.keys.first;

    int max = genres[favoriteGenre]!;

    genres.forEach((genre, count) {

      if (count > max) {

        max = count;

        favoriteGenre = genre;
      }
    });

    return favoriteGenre;
  }

  @override
  Widget build(BuildContext context) {

    final genreCount = countGenres();

    final filteredMovies =
        selectedGenre == 'Todos'

            ? FavoritesService.favoriteMovies

            : FavoritesService.favoriteMovies
                .where(
                  (movie) =>
                      movie.genre ==
                      selectedGenre,
                )
                .toList();

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Relatórios',
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: SingleChildScrollView(

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const Text(

                '📊 Estatísticas',

                style: TextStyle(

                  fontSize: 24,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Card(

                child: ListTile(

                  leading: const Icon(
                    Icons.favorite,
                  ),

                  title: const Text(
                    'Total de Favoritos',
                  ),

                  trailing: Text(

                    FavoritesService
                        .favoriteMovies
                        .length
                        .toString(),

                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              Card(

                child: ListTile(

                  leading: const Icon(
                    Icons.star,
                  ),

                  title: const Text(
                    'Gênero Favorito',
                  ),

                  trailing: Text(
                    getFavoriteGenre(),
                  ),
                ),
              ),

              Card(

                child: ListTile(

                  leading: const Icon(
                    Icons.movie,
                  ),

                  title: const Text(
                    'Último Filme',
                  ),

                  trailing: Text(

                    FavoritesService
                            .favoriteMovies
                            .isEmpty

                        ? 'Nenhum'

                        : FavoritesService
                            .favoriteMovies
                            .last
                            .title,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Text(

                '🎭 Filmes por Gênero',

                style: TextStyle(

                  fontSize: 22,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              ...genreCount.entries.map(

                (entry) {

                  return Card(

                    child: ListTile(

                      leading: const Icon(
                        Icons.category,
                      ),

                      title: Text(
                        entry.key,
                      ),

                      trailing: Text(
                        entry.value.toString(),
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              const Text(

                '🔍 Filtrar por Gênero',

                style: TextStyle(

                  fontSize: 22,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              DropdownButtonFormField<String>(

                value: selectedGenre,

                dropdownColor:
                    const Color(0xFF1E1E1E),

                items: getGenres().map((genre) {

                  return DropdownMenuItem(

                    value: genre,

                    child: Text(genre),
                  );

                }).toList(),

                onChanged: (value) {

                  setState(() {

                    selectedGenre = value!;
                  });
                },
              ),

              const SizedBox(height: 20),

              ...filteredMovies.map(

                (movie) {

                  return Card(

                    child: ListTile(

                      leading: const Icon(
                        Icons.movie,
                      ),

                      title: Text(
                        movie.title,
                      ),

                      subtitle: Text(
                        movie.genre,
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              const Text(

                '🕘 Últimas Pesquisas',

                style: TextStyle(

                  fontSize: 22,

                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              if (SearchService
                  .recentSearches
                  .isEmpty)

                const Text(
                  'Nenhuma pesquisa realizada',
                ),

              ...SearchService
                  .recentSearches
                  .map(

                (search) {

                  return Card(

                    child: ListTile(

                      leading: const Icon(
                        Icons.search,
                      ),

                      title: Text(search),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../models/movie.dart';
import '../models/favorite_movie.dart';

import '../services/api_service.dart';
import '../services/favorites_service.dart';
import '../services/search_service.dart';

import 'movie_details_page.dart';
import 'favorite_movies_page.dart';
import 'reports_page.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController controller =
      TextEditingController();

  final ApiService apiService = ApiService();

  List<Movie> movies = [];

  bool isLoading = false;

  Future<void> searchMovies() async {

    if (controller.text.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            'Digite o nome de um filme',
          ),
        ),
      );

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final result =
          await apiService.searchMovies(
            controller.text,
          );

      SearchService.recentSearches.insert(
        0,
        controller.text,
      );

      if (SearchService
              .recentSearches.length >
          5) {

        SearchService.recentSearches
            .removeLast();
      }

      setState(() {
        movies = result;
      });

    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            'Erro ao buscar filmes',
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  void addToFavorites(Movie movie) {

    bool alreadyExists =
        FavoritesService.favoriteMovies.any(

      (favorite) =>
          favorite.title == movie.title,
    );

    if (alreadyExists) {

      ScaffoldMessenger.of(context).showSnackBar(

        SnackBar(

          content: Text(
            '${movie.title} já está nos favoritos',
          ),
        ),
      );

      return;
    }

    FavoritesService.favoriteMovies.add(

      FavoriteMovie(

        title: movie.title,

        genre: movie.genre,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(

      SnackBar(

        content: Text(
          '${movie.title} adicionado aos favoritos',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Catálogo de Filmes',
        ),
      ),

      drawer: Drawer(

        child: ListView(

          children: [

            const DrawerHeader(

              decoration: BoxDecoration(
                color: Color(0xFF800020),
              ),

              child: Column(

                mainAxisAlignment:
                    MainAxisAlignment.center,

                children: [

                  Icon(

                    Icons.movie_creation_outlined,

                    color: Colors.white,

                    size: 60,
                  ),

                  SizedBox(height: 10),

                  Text(

                    'CineVerse',

                    style: TextStyle(

                      color: Colors.white,

                      fontSize: 24,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            ListTile(

              leading:
                  const Icon(Icons.home),

              title: const Text('Home'),

              onTap: () {
                Navigator.pop(context);
              },
            ),

            ListTile(

              leading:
                  const Icon(Icons.favorite),

              title: const Text(
                'Filmes Favoritos',
              ),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) =>
                        const FavoriteMoviesPage(),
                  ),
                );
              },
            ),

            ListTile(

              leading:
                  const Icon(Icons.bar_chart),

              title:
                  const Text('Relatórios'),

              onTap: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) =>
                        const ReportsPage(),
                  ),
                );
              },
            ),

            const Divider(),

            ListTile(

              leading:
                  const Icon(Icons.logout),

              title: const Text('Sair'),

              onTap: () {

                Navigator.pushReplacement(

                  context,

                  MaterialPageRoute(

                    builder: (context) =>
                        const LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              controller: controller,

              style: const TextStyle(
                color: Colors.white,
              ),

              textInputAction:
                  TextInputAction.search,

              onSubmitted: (value) {
                searchMovies();
              },

              decoration:
                  const InputDecoration(

                labelText:
                    'Digite o nome do filme',

                prefixIcon:
                    Icon(Icons.search),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                onPressed: searchMovies,

                icon: const Icon(
                  Icons.search,
                ),

                label: const Text(
                  'Buscar',
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (isLoading)

              const Expanded(

                child: Center(

                  child:
                      CircularProgressIndicator(),
                ),
              ),

            if (!isLoading)

              Expanded(

                child: movies.isEmpty

                    ? const Center(

                        child: Text(

                          'Pesquise um filme para começar',

                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      )

                    : ListView.builder(

                        itemCount:
                            movies.length,

                        itemBuilder:
                            (context, index) {

                          final movie =
                              movies[index];

                          return GestureDetector(

                            onTap: () {

                              Navigator.push(

                                context,

                                MaterialPageRoute(

                                  builder:
                                      (context) =>
                                          MovieDetailsPage(
                                            movie:
                                                movie,
                                          ),
                                ),
                              );
                            },

                            child: Card(

                              margin:
                                  const EdgeInsets.only(
                                bottom: 12,
                              ),

                              child: ListTile(

                                contentPadding:
                                    const EdgeInsets.all(
                                  10,
                                ),

                                leading:
                                    movie.poster !=
                                            'N/A'
                                        ? ClipRRect(

                                            borderRadius:
                                                BorderRadius.circular(
                                              10,
                                            ),

                                            child:
                                                Image.network(

                                              movie.poster,

                                              width: 60,

                                              fit: BoxFit.cover,
                                            ),
                                          )

                                        : const Icon(
                                            Icons.movie,
                                            size: 40,
                                          ),

                                title: Text(

                                  movie.title,

                                  style:
                                      const TextStyle(

                                    fontWeight:
                                        FontWeight.bold,
                                  ),
                                ),

                                subtitle: Column(

                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                  children: [

                                    const SizedBox(
                                      height: 5,
                                    ),

                                    Text(
                                      movie.year,
                                    ),

                                    Text(
                                      '⭐ IMDb: ${movie.imdbRating}',
                                    ),
                                  ],
                                ),

                                trailing:
                                    IconButton(

                                  icon: const Icon(

                                    Icons.favorite_border,

                                    color: Colors.red,
                                  ),

                                  onPressed: () {

                                    addToFavorites(
                                      movie,
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
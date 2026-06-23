import 'package:flutter/material.dart';

import '../models/favorite_movie.dart';
import '../services/favorites_service.dart';

class FavoriteMoviesPage extends StatefulWidget {

  const FavoriteMoviesPage({super.key});

  @override
  State<FavoriteMoviesPage> createState() =>
      _FavoriteMoviesPageState();
}

class _FavoriteMoviesPageState
    extends State<FavoriteMoviesPage> {

  final TextEditingController titleController =
      TextEditingController();

  final List<String> genres = [

    'Ação',
    'Aventura',
    'Comédia',
    'Drama',
    'Ficção Científica',
    'Romance',
    'Suspense',
    'Terror',
    'Fantasia',
    'Animação',
  ];

  String? selectedGenre;

  void addMovie() {

    final title = titleController.text;

    if (title.isEmpty ||
        selectedGenre == null) {

      ScaffoldMessenger.of(context).showSnackBar(

        const SnackBar(

          content: Text(
            'Preencha todos os campos',
          ),
        ),
      );

      return;
    }

    FavoritesService.favoriteMovies.add(

      FavoriteMovie(

        title: title,

        genre: selectedGenre!,
      ),
    );

    setState(() {});

    titleController.clear();

    selectedGenre = null;
  }

  void removeMovie(int index) {

    setState(() {

      FavoritesService.favoriteMovies
          .removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'Filmes Favoritos',
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            TextField(

              controller: titleController,

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration: const InputDecoration(

                labelText: 'Nome do Filme',

                prefixIcon:
                    Icon(Icons.movie),
              ),
            ),

            const SizedBox(height: 10),

            DropdownButtonFormField<String>(

              value: selectedGenre,

              dropdownColor:
                  const Color(0xFF1E1E1E),

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration:
                  const InputDecoration(

                labelText: 'Gênero',

                prefixIcon:
                    Icon(Icons.category),
              ),

              items: genres.map((genre) {

                return DropdownMenuItem(

                  value: genre,

                  child: Text(genre),
                );

              }).toList(),

              onChanged: (value) {

                setState(() {

                  selectedGenre = value;
                });
              },
            ),

            const SizedBox(height: 10),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton.icon(

                onPressed: addMovie,

                icon: const Icon(
                  Icons.add,
                ),

                label: const Text(
                  'Adicionar Filme',
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(

              child: FavoritesService
                      .favoriteMovies
                      .isEmpty

                  ? const Center(

                      child: Text(

                        'Nenhum filme favoritado',

                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )

                  : ListView.builder(

                      itemCount:
                          FavoritesService
                              .favoriteMovies
                              .length,

                      itemBuilder:
                          (context, index) {

                        final movie =
                            FavoritesService
                                .favoriteMovies[index];

                        return Card(

                          margin:
                              const EdgeInsets.only(
                            bottom: 10,
                          ),

                          child: ListTile(

                            leading: const Icon(

                              Icons.favorite,

                              color: Colors.red,
                            ),

                            title: Text(
                              movie.title,
                            ),

                            subtitle: Text(
                              movie.genre,
                            ),

                            trailing:
                                IconButton(

                              icon: const Icon(

                                Icons.delete,

                                color: Colors.red,
                              ),

                              onPressed: () {
                                removeMovie(index);
                              },
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
import 'package:flutter/material.dart';

import '../models/movie.dart';

class MovieDetailsPage extends StatelessWidget {

  final Movie movie;

  const MovieDetailsPage({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text(movie.title),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Center(

              child: ClipRRect(

                borderRadius: BorderRadius.circular(12),

                child: Image.network(
                  movie.poster,
                  height: 400,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              movie.title,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Ano: ${movie.year}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              '⭐ IMDb: ${movie.imdbRating}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              '🎭 Gênero: ${movie.genre}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 10),

            Text(
              '🎬 Diretor: ${movie.director}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            const Text(
              'Sinopse',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              movie.plot,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
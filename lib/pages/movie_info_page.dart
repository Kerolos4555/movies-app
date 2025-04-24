import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieInfoPage extends StatelessWidget {
  final MovieModel movieModel;
  const MovieInfoPage({super.key, required this.movieModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          movieModel.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image(
              fit: BoxFit.fill,
              height: 250,
              width: double.infinity,
              image: NetworkImage(
                'https://image.tmdb.org/t/p/w500${movieModel.posterImage}',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                movieModel.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'original language: ${movieModel.language}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 30,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  movieModel.vote.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Release Date: ${movieModel.releaseDate}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'is Adult: ${movieModel.isAdult}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                movieModel.overview,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

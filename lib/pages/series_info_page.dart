import 'package:flutter/material.dart';
import 'package:movie_app/models/series_model.dart';

class SeriesInfoPage extends StatelessWidget {
  final SeriesModel seriesModel;
  const SeriesInfoPage({super.key, required this.seriesModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          seriesModel.title,
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
                'https://image.tmdb.org/t/p/w500${seriesModel.posterImage}',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                seriesModel.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              'original language: ${seriesModel.language}',
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
                  seriesModel.vote.toString(),
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
                    'Release Date: ${seriesModel.releaseDate}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'is Adult: ${seriesModel.isAdult}',
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
                seriesModel.overview,
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

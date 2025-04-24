import 'package:flutter/material.dart';
import 'package:movie_app/models/series_model.dart';
import 'package:movie_app/pages/series_info_page.dart';

class SeriesItem extends StatelessWidget {
  final SeriesModel series;
  const SeriesItem({super.key, required this.series});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SeriesInfoPage(
                seriesModel: series,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image(
              height: 160,
              width: 100,
              fit: BoxFit.fill,
              image: NetworkImage(
                'https://image.tmdb.org/t/p/w500${series.posterImage}',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    series.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    series.releaseDate,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 26,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        series.vote.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

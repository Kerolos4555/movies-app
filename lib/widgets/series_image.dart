import 'package:flutter/material.dart';
import 'package:movie_app/models/series_model.dart';
import 'package:movie_app/pages/series_info_page.dart';

class SeriesImage extends StatelessWidget {
  final SeriesModel seriesModel;
  const SeriesImage({super.key, required this.seriesModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return SeriesInfoPage(
                seriesModel: seriesModel,
              );
            },
          ),
        );
      },
      child: Card(
        elevation: 5,
        child: SizedBox(
          width: 120,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  fit: BoxFit.fill,
                  height: 180,
                  image: NetworkImage(
                    'https://image.tmdb.org/t/p/w500${seriesModel.posterImage}',
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      seriesModel.vote.toString(),
                    ),
                  ],
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Text(
                      seriesModel.title,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, bottom: 8),
                  child: Text(
                    seriesModel.releaseDate,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

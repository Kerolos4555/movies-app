import 'package:flutter/material.dart';
import 'package:movie_app/widgets/carousel_builder.dart';
import 'package:movie_app/widgets/top_movies.dart';
import 'package:movie_app/widgets/top_series.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: CarouselSliderBuilder(),
            ),
            SliverToBoxAdapter(
              child: TopMovies(),
            ),
            SliverToBoxAdapter(
              child: TopSeries(),
            ),
          ],
        ),
      ),
    );
  }
}

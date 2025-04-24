import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/carousel_cubit/carousel_cubit.dart';
import 'package:movie_app/cubits/carousel_cubit/carousel_states.dart';
import 'package:movie_app/pages/movie_info_page.dart';

class CarouselSliderBuilder extends StatelessWidget {
  const CarouselSliderBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselCubit, CarouselStates>(
      builder: (context, state) {
        if (state is GetPopularMoviesSuccessState) {
          return CarouselSlider(
            items: CarouselCubit.get(context)
                .moviesList
                .map(
                  (movie) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MovieInfoPage(
                              movieModel: movie,
                            );
                          },
                        ),
                      );
                    },
                    child: Image(
                      fit: BoxFit.fill,
                      width: double.infinity,
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${movie.posterImage}',
                      ),
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 400,
              viewportFraction: 1,
              enlargeCenterPage: false,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          );
        } else if (state is GetPopularMoviesErrorState) {
          return Center(
            child: Text(
              'There was an error ${state.errorMessage}',
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

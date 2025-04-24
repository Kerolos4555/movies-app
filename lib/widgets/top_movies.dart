import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/top_movies_cubit/top_movies_cubit.dart';
import 'package:movie_app/cubits/top_movies_cubit/top_movies_states.dart';
import 'package:movie_app/pages/see_all_movies_page.dart';
import 'package:movie_app/widgets/movie_image.dart';

class TopMovies extends StatelessWidget {
  const TopMovies({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopMoviesCubit, TopMoviesStates>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
            left: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Top movies',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SeeAllMoviesPage(
                              movies: TopMoviesCubit.get(context).topMoviesList,
                            );
                          },
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Text(
                        'see all',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 320,
                child: state is GetTopMoviesSuccessState
                    ? ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return MovieImage(
                            movieModel: TopMoviesCubit.get(context)
                                .topMoviesList[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            width: 8,
                          );
                        },
                        itemCount:
                            TopMoviesCubit.get(context).topMoviesList.length,
                      )
                    : state is GetTopMoviesErrorState
                        ? Center(
                            child: Text(
                              'There was an error ${state.errorMessage}',
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}

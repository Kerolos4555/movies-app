import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/top_movies_cubit/top_movies_cubit.dart';
import 'package:movie_app/cubits/top_movies_cubit/top_movies_states.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/widgets/movie_item.dart';

class SeeAllMoviesPage extends StatefulWidget {
  final List<MovieModel> movies;
  const SeeAllMoviesPage({super.key, required this.movies});

  @override
  State<SeeAllMoviesPage> createState() => _SeeAllMoviesPageState();
}

class _SeeAllMoviesPageState extends State<SeeAllMoviesPage> {
  late final ScrollController scrollController;
  int nextPage = 2;
  bool isLoading = false;
  List<MovieModel> moviesList = [];

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(scrollListener);
    moviesList.addAll(widget.movies);
    super.initState();
  }

  void scrollListener() async {
    var currentPosition = scrollController.position.pixels;
    var maxPosition = scrollController.position.maxScrollExtent;
    if (currentPosition >= 0.7 * maxPosition) {
      if (!isLoading) {
        isLoading = true;
        await TopMoviesCubit.get(context).getTopMovies(pageNumber: nextPage++);
        isLoading = false;
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TopMoviesCubit, TopMoviesStates>(
      listener: (context, state) {
        if (state is GetTopMoviesSuccessState) {
          moviesList.addAll(TopMoviesCubit.get(context).topMoviesList);
        }
      },
      builder: (context, state) {
        if (state is GetTopMoviesSuccessState ||
            state is GetTopMoviesPaginationLoadingState ||
            state is GetTopMoviesPaginationErrorState) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: const Text(
                'Top Movies',
              ),
            ),
            body: ListView.separated(
              controller: scrollController,
              itemBuilder: (context, index) {
                return MovieItem(
                  movie: moviesList[index],
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.grey[700],
                  ),
                );
              },
              itemCount: moviesList.length,
            ),
          );
        } else if (state is GetTopMoviesErrorState) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: const Text(
                'Top Movies',
              ),
            ),
            body: Center(
              child: Text(
                'There was an error ${state.errorMessage}',
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: const Text(
                'Top Movies',
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

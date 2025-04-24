import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/top_movies_cubit/top_movies_states.dart';
import 'package:movie_app/data/repo.dart';
import 'package:movie_app/models/movie_model.dart';

class TopMoviesCubit extends Cubit<TopMoviesStates> {
  final Repo repo;
  TopMoviesCubit({required this.repo}) : super(TopMoviesInitialState());
  static TopMoviesCubit get(context) => BlocProvider.of(context);

  late List<MovieModel> topMoviesList;
  Future<void> getTopMovies({int pageNumber = 1}) async {
    if (pageNumber == 1) {
      emit(GetTopMoviesLoadingState());
    } else {
      emit(GetTopMoviesPaginationLoadingState());
    }
    var result = await repo.fetchTopMovies(pageNumber: pageNumber);
    result.fold(
      (failure) {
        if (pageNumber == 1) {
          emit(GetTopMoviesErrorState(errorMessage: failure.errorMessage));
        } else {
          emit(GetTopMoviesPaginationErrorState(
              errorMessage: failure.errorMessage));
        }
      },
      (movies) {
        topMoviesList = movies;
        emit(GetTopMoviesSuccessState());
      },
    );
  }
}

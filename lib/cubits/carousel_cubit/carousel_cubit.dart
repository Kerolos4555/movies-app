import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/carousel_cubit/carousel_states.dart';
import 'package:movie_app/data/repo.dart';
import 'package:movie_app/models/movie_model.dart';

class CarouselCubit extends Cubit<CarouselStates> {
  Repo repo;
  CarouselCubit({
    required this.repo,
  }) : super(CarouselInitState());

  static CarouselCubit get(context) => BlocProvider.of(context);

  late List<MovieModel> moviesList;
  Future<void> getPopularMovies() async {
    emit(GetPopularMoviesLoadingState());
    var result = await repo.fetchPopularMovies();
    result.fold(
      (failure) {
        emit(
          GetPopularMoviesErrorState(errorMessage: failure.errorMessage),
        );
      },
      (movies) {
        moviesList = movies;
        emit(GetPopularMoviesSuccessState());
      },
    );
  }
}

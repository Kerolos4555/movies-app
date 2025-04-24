abstract class TopMoviesStates {}

class TopMoviesInitialState extends TopMoviesStates {}

class GetTopMoviesLoadingState extends TopMoviesStates {}

class GetTopMoviesSuccessState extends TopMoviesStates {}

class GetTopMoviesErrorState extends TopMoviesStates {
  final String errorMessage;

  GetTopMoviesErrorState({required this.errorMessage});
}

class GetTopMoviesPaginationLoadingState extends TopMoviesStates {}

class GetTopMoviesPaginationErrorState extends TopMoviesStates {
  final String errorMessage;

  GetTopMoviesPaginationErrorState({required this.errorMessage});
}

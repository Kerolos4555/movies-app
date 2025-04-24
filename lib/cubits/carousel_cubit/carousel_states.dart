abstract class CarouselStates {}

class CarouselInitState extends CarouselStates {}

class GetPopularMoviesLoadingState extends CarouselStates {}

class GetPopularMoviesSuccessState extends CarouselStates {}

class GetPopularMoviesErrorState extends CarouselStates {
  final String errorMessage;

  GetPopularMoviesErrorState({required this.errorMessage});
}

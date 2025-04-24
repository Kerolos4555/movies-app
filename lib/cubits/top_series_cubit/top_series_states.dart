abstract class TopSeriesStates {}

class TopSeriesInitialstate extends TopSeriesStates {}

class GetTopSeriesLoadingState extends TopSeriesStates {}

class GetTopSeriesSuccessState extends TopSeriesStates {}

class GetTopSeriesErrorState extends TopSeriesStates {
  final String errorMessage;

  GetTopSeriesErrorState({required this.errorMessage});
}

class GetTopSeriesPaginationLoadingState extends TopSeriesStates {}

class GetTopSeriesPaginationErrorState extends TopSeriesStates {
  final String errorMessage;

  GetTopSeriesPaginationErrorState({required this.errorMessage});
}

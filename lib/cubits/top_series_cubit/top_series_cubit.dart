import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubits/top_series_cubit/top_series_states.dart';
import 'package:movie_app/data/repo.dart';
import 'package:movie_app/models/series_model.dart';

class TopSeriesCubit extends Cubit<TopSeriesStates> {
  final Repo repo;
  TopSeriesCubit({required this.repo}) : super(TopSeriesInitialstate());
  static TopSeriesCubit get(context) => BlocProvider.of(context);

  late List<SeriesModel> topSeriesList;
  Future<void> getTopSeries({int pageNumber = 1}) async {
    if (pageNumber == 1) {
      emit(GetTopSeriesLoadingState());
    } else {
      emit(GetTopSeriesPaginationLoadingState());
    }
    var result = await repo.fetchTopTvSeries(pageNumber: pageNumber);
    result.fold(
      (failure) {
        if (pageNumber == 1) {
          emit(GetTopSeriesPaginationErrorState(
              errorMessage: failure.errorMessage));
        }
      },
      (series) {
        topSeriesList = series;
        emit(GetTopSeriesSuccessState());
      },
    );
  }
}

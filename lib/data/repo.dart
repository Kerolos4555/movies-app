import 'package:dartz/dartz.dart';
import 'package:movie_app/error/failures.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/series_model.dart';

abstract class Repo {
  Future<Either<Failure, List<MovieModel>>> fetchPopularMovies();
  Future<Either<Failure, List<MovieModel>>> fetchTopMovies({int pageNumber = 1});
  Future<Either<Failure, List<SeriesModel>>> fetchTopTvSeries({int pageNumber = 1});
}

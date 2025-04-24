import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/data/repo.dart';
import 'package:movie_app/error/failures.dart';
import 'package:movie_app/helper/dio_helper.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/series_model.dart';

class RepoImpl extends Repo {
  @override
  Future<Either<Failure, List<MovieModel>>> fetchPopularMovies() async {
    try {
      var data = await DioHelper.getData(
        url: 'movie/popular',
        query: {
          'language': 'en',
          'page': '1',
          'api_key': 'b6f57ef70125b7ca210a8f3b4f28c626',
        },
      );
      List<MovieModel> moviesList = [];
      for (var item in data.data['results']) {
        moviesList.add(MovieModel.fromJson(item));
      }
      return right(moviesList);
    } on DioException catch (exception) {
      return left(
        ServerFailure.fromDioException(exception),
      );
    } catch (exception) {
      return left(
        ServerFailure(errorMessage: exception.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> fetchTopMovies({
    int pageNumber = 1,
  }) async {
    try {
      var data = await DioHelper.getData(
        url: 'movie/top_rated',
        query: {
          'language': 'en',
          'page': '$pageNumber',
          'api_key': 'b6f57ef70125b7ca210a8f3b4f28c626',
        },
      );
      List<MovieModel> moviesList = [];
      for (var item in data.data['results']) {
        moviesList.add(MovieModel.fromJson(item));
      }
      return right(moviesList);
    } on DioException catch (exception) {
      return left(
        ServerFailure.fromDioException(exception),
      );
    } catch (exception) {
      return left(
        ServerFailure(errorMessage: exception.toString()),
      );
    }
  }

  @override
  Future<Either<Failure, List<SeriesModel>>> fetchTopTvSeries({
    int pageNumber = 1,
  }) async {
    try {
      var data = await DioHelper.getData(
        url: 'tv/top_rated',
        query: {
          'language': 'en',
          'page': '$pageNumber',
          'api_key': 'b6f57ef70125b7ca210a8f3b4f28c626',
        },
      );
      List<SeriesModel> seriesList = [];
      for (var item in data.data['results']) {
        seriesList.add(SeriesModel.fromJson(item));
      }
      return right(seriesList);
    } on DioException catch (exception) {
      return left(
        ServerFailure.fromDioException(exception),
      );
    } catch (exception) {
      return left(
        ServerFailure(errorMessage: exception.toString()),
      );
    }
  }
}

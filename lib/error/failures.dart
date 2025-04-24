import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMessage;

  Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
  factory ServerFailure.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errorMessage: 'Connection timeout with API server',
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(
          errorMessage: 'Send timeout with API server',
        );
      case DioExceptionType.receiveTimeout:
        return ServerFailure(
          errorMessage: 'Receive timeout with API server',
        );
      case DioExceptionType.badCertificate:
        return ServerFailure(
          errorMessage: 'SSL/TLS certificate is not valid or trusted',
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          statusCode: dioException.response!.statusCode!,
          response: dioException.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          errorMessage: 'Request to API server was canceld',
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          errorMessage: 'NO internet connection',
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          errorMessage: 'Unexpected Error, please try again later',
        );
    }
  }

  factory ServerFailure.fromResponse({
    required int statusCode,
    required dynamic response,
  }) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(
        errorMessage: response['error']['message'],
      );
    } else if (statusCode == 404) {
      return ServerFailure(
        errorMessage: 'your request not found, please try again later',
      );
    } else if (statusCode == 500) {
      return ServerFailure(
        errorMessage: 'Internal server error, please try again later',
      );
    } else {
      return ServerFailure(
        errorMessage: 'OOPS, There was an error, please try again later',
      );
    }
  }
}

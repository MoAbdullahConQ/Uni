import 'dart:io';

import 'package:dio/dio.dart';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class ServerFailure extends Failure {
  ServerFailure(super.message);

  factory ServerFailure.fromDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with API server');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with API server');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with API server');
      case DioExceptionType.badCertificate:
        return ServerFailure('Bad certificate from API server');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
          e.response!.statusCode,
          e.response!.data,
        );
      case DioExceptionType.cancel:
        return ServerFailure('Request to API server was cancelled');
      case DioExceptionType.connectionError:
        return ServerFailure('No Internet Connection');
      case DioExceptionType.unknown:
        if (e.error is SocketException) {
          return ServerFailure('No Internet Connection');
        } else {
          return ServerFailure('Unexpected error occurred');
        }
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(
        response?['error']?['message'] ??
            response?['message'] ??
            'Something went wrong',
      );
    } else if (statusCode == 404) {
      return ServerFailure('Your request not found, Please try later!');
    } else if (statusCode == 429) {
      return ServerFailure('Too many requests, Please try later!');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error, Please try later!');
    } else {
      return ServerFailure('Oops, Something went wrong, Please try later!');
    }
  }
}

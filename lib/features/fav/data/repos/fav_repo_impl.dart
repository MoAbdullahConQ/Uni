import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:uni/core/entities/unis_response.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/fav/data/data_sources/fav_remote_data_source.dart';
import 'package:uni/features/fav/domain/repos/fav_repo.dart';

class FavRepoImpl implements FavRepo {
  final FavRemoteDataSource remoteDataSource;

  FavRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UnisResponse>> getFavs({String? cursor}) async {
    try {
      final response = await remoteDataSource.getFavs(cursor: cursor);
      return right(response);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> addToFav(int universityId) async {
    try {
      await remoteDataSource.addToFav(universityId);
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFav(int universityId) async {
    try {
      await remoteDataSource.removeFromFav(universityId);
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}

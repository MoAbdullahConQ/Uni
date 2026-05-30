import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/browse/domain/entities/unis_response.dart';

abstract class FavRepo {
  Future<Either<Failure, UnisResponse>> getFavs({String? cursor});
  Future<Either<Failure, void>> addToFav(int universityId);
  Future<Either<Failure, void>> removeFromFav(int universityId);
}

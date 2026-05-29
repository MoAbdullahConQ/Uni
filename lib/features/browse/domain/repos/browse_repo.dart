import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/browse/domain/entities/unis_response.dart';

abstract class BrowseRepo {
  Future<Either<Failure, UnisResponse>> getUnis({String? cursor});
}

import 'package:dartz/dartz.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/errors/failures.dart';

abstract class BrowseRepo {
  Future<Either<Failure, List<UniEntity>>> getUnis();
}

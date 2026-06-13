import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_detail_entity.dart';

abstract class UniDetailRepo {
  Future<Either<Failure, UniDetailEntity>> getUniDetail(int id);
}

import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_detail_entity.dart';
import 'package:uni/features/uni_detail/domain/repos/uni_detail_repo.dart';

class GetUniDetailUseCase {
  final UniDetailRepo repo;

  GetUniDetailUseCase(this.repo);

  Future<Either<Failure, UniDetailEntity>> call(int id) {
    return repo.getUniDetail(id);
  }
}

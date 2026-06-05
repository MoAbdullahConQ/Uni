import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/search/domain/repos/search_repo.dart';

class GetSpecialtiesUseCase {
  final SearchRepo searchRepo;

  GetSpecialtiesUseCase(this.searchRepo);

  Future<Either<Failure, List<String>>> call() {
    return searchRepo.getSpecialties();
  }
}

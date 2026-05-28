import 'package:dartz/dartz.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/browse/domain/repos/browse_repo.dart';

class GetUnisUseCase {
  final BrowseRepo browseRepo;

  GetUnisUseCase(this.browseRepo);

  Future<Either<Failure, List<UniEntity>>> call() {
    return browseRepo.getUnis();
  }
}

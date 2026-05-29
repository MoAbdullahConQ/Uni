import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/browse/domain/entities/unis_response.dart';
import 'package:uni/features/browse/domain/repos/browse_repo.dart';

class GetUnisUseCase {
  final BrowseRepo browseRepo;

  GetUnisUseCase(this.browseRepo);

  Future<Either<Failure, UnisResponse>> call({String? cursor}) {
    return browseRepo.getUnis(cursor: cursor);
  }
}

import 'package:dartz/dartz.dart';
import 'package:uni/core/entities/unis_response.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/fav/domain/repos/fav_repo.dart';

class GetFavsUseCase {
  final FavRepo favRepo;

  GetFavsUseCase(this.favRepo);

  Future<Either<Failure, UnisResponse>> call({String? cursor}) {
    return favRepo.getFavs(cursor: cursor);
  }
}

import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/fav/domain/repos/fav_repo.dart';

class RemoveFromFavUseCase {
  final FavRepo favRepo;

  RemoveFromFavUseCase(this.favRepo);

  Future<Either<Failure, void>> call(int universityId) {
    return favRepo.removeFromFav(universityId);
  }
}

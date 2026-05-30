import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/fav/domain/repos/fav_repo.dart';

class AddToFavUseCase {
  final FavRepo favRepo;

  AddToFavUseCase(this.favRepo);

  Future<Either<Failure, void>> call(int universityId) {
    return favRepo.addToFav(universityId);
  }
}

import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/auth/domain/entities/user_entity.dart';
import 'package:uni/features/auth/domain/repos/auth_repo.dart';

// Used in profile feature
class GetMeUseCase {
  final AuthRepo authRepo;

  GetMeUseCase(this.authRepo);

  Future<Either<Failure, UserEntity>> call() {
    return authRepo.getMe();
  }
}

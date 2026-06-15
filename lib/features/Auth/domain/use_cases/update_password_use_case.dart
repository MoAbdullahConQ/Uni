import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/auth/domain/repos/auth_repo.dart';

// Used in profile feature (security screen)
class UpdatePasswordUseCase {
  final AuthRepo authRepo;

  UpdatePasswordUseCase(this.authRepo);

  Future<Either<Failure, void>> call({
    required String password,
    required String passwordConfirmation,
  }) {
    return authRepo.updatePassword(
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}

import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/auth/domain/repos/auth_repo.dart';

class ResetPasswordUseCase {
  final AuthRepo authRepo;

  ResetPasswordUseCase(this.authRepo);

  Future<Either<Failure, void>> call({
    required String password,
    required String passwordConfirmation,
  }) {
    return authRepo.resetPassword(
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
  }
}

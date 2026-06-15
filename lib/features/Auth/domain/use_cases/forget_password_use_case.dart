import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/auth/domain/repos/auth_repo.dart';

class ForgetPasswordUseCase {
  final AuthRepo authRepo;

  ForgetPasswordUseCase(this.authRepo);

  Future<Either<Failure, void>> call({required String email}) {
    return authRepo.forgetPassword(email: email);
  }
}

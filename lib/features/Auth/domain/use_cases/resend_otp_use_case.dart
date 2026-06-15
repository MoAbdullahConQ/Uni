import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/auth/domain/repos/auth_repo.dart';

class ResendOtpUseCase {
  final AuthRepo authRepo;

  ResendOtpUseCase(this.authRepo);

  Future<Either<Failure, void>> call({required String email}) {
    return authRepo.resendOtp(email: email);
  }
}

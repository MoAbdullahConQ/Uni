import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/auth/domain/repos/auth_repo.dart';

class VerifyOtpUseCase {
  final AuthRepo authRepo;

  VerifyOtpUseCase(this.authRepo);

  Future<Either<Failure, String>> call({
    required String otp,
    required String email,
  }) {
    return authRepo.verifyOtp(otp: otp, email: email);
  }
}

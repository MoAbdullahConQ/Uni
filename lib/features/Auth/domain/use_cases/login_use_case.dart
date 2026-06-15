import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/auth/domain/entities/auth_entity.dart';
import 'package:uni/features/auth/domain/repos/auth_repo.dart';

class LoginUseCase {
  final AuthRepo authRepo;

  LoginUseCase(this.authRepo);

  Future<Either<Failure, AuthEntity>> call({
    required String email,
    required String password,
  }) {
    return authRepo.login(email: email, password: password);
  }
}

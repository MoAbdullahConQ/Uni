import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/auth/domain/repos/auth_repo.dart';

class UploadAvatarUseCase {
  final AuthRepo authRepo;

  UploadAvatarUseCase(this.authRepo);

  Future<Either<Failure, void>> call(File image) {
    return authRepo.uploadAvatar(image);
  }
}

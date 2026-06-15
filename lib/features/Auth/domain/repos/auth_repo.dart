import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, AuthEntity>> verifyOtp({
    required String otp,
    required String email,
  });

  Future<Either<Failure, void>> forgetPassword({
    required String email,
  });

  Future<Either<Failure, void>> resendOtp({
    required String email,
  });

  Future<Either<Failure, void>> resetPassword({
    required String password,
    required String passwordConfirmation,
  });

  Future<Either<Failure, void>> saveStudentInfo({
    required String studySection,
    required String scientificDepartment,
    required int governorateId,
    required double percentage,
    required int age,
  });
}

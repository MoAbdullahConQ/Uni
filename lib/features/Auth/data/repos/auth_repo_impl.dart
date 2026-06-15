import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:uni/features/auth/domain/entities/user_entity.dart';
import 'package:uni/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, void>> login({
    required String email,
    required String password,
  }) async {
    try {
      await remoteDataSource.login(email: email, password: password);
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await remoteDataSource.register(
        name: name,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp({
    required String otp,
    required String email,
  }) async {
    try {
      final token = await remoteDataSource.verifyOtp(otp: otp, email: email);
      return right(token);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword({required String email}) async {
    try {
      await remoteDataSource.forgetPassword(email: email);
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> resendOtp({required String email}) async {
    try {
      await remoteDataSource.resendOtp(email: email);
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword({
    required String password,
    required String passwordConfirmation,
    required String tempToken,
  }) async {
    try {
      await remoteDataSource.resetPassword(
        password: password,
        passwordConfirmation: passwordConfirmation,
        tempToken: tempToken,
      );
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> saveStudentInfo({
    required String studySection,
    required String scientificDepartment,
    required int governorateId,
    required double percentage,
    required int age,
  }) async {
    try {
      await remoteDataSource.saveStudentInfo(
        studySection: studySection,
        scientificDepartment: scientificDepartment,
        governorateId: governorateId,
        percentage: percentage,
        age: age,
      );
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> updatePassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      await remoteDataSource.updatePassword(
        password: password,
        passwordConfirmation: passwordConfirmation,
      );
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getMe() async {
    try {
      final user = await remoteDataSource.getMe();
      return right(user);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
  
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/services/shared_preferences_singleton.dart';
import 'package:uni/features/auth/domain/use_cases/forget_password_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/login_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/register_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/save_student_info_use_case.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final SaveStudentInfoUseCase saveStudentInfoUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.forgetPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.saveStudentInfoUseCase,
  }) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    final result = await loginUseCase.call(email: email, password: password);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(AuthLoading());
    final result = await registerUseCase.call(
      name: name,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> forgetPassword({required String email}) async {
    emit(AuthLoading());
    final result = await forgetPasswordUseCase.call(email: email);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> resetPassword({
    required String password,
    required String passwordConfirmation,
    required String tempToken,
  }) async {
    emit(AuthLoading());
    final result = await resetPasswordUseCase.call(
      password: password,
      passwordConfirmation: passwordConfirmation,
      tempToken: tempToken,
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  Future<void> saveStudentInfo({
    required String studySection,
    required String? scientificDepartment,
    required int governorateId,
    required double percentage,
    required int age,
  }) async {
    emit(AuthLoading());
    final result = await saveStudentInfoUseCase.call(
      studySection: studySection,
      scientificDepartment: scientificDepartment,
      governorateId: governorateId,
      percentage: percentage,
      age: age,
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthSuccess()),
    );
  }

  // clear tokens on logout
  Future<void> logout() async {
    await Prefs.remove('token');
    await Prefs.remove('refresh_token');
  }
}

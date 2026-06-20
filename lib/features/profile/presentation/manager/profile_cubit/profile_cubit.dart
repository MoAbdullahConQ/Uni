import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/services/shared_preferences_singleton.dart';
import 'package:uni/features/auth/domain/entities/user_entity.dart';
import 'package:uni/features/auth/domain/use_cases/get_me_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/save_student_info_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/update_password_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/upload_avatar_use_case.dart';
import 'package:uni/features/auth/presentation/views/login_view.dart';
import 'package:uni/main.dart';

part 'profile_state.dart';

// Single cubit for profile, personal_data, and security screens —
// they all operate on the same "object" (the current user's data).
class ProfileCubit extends Cubit<ProfileState> {
  final GetMeUseCase getMeUseCase;
  final SaveStudentInfoUseCase saveStudentInfoUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;
  final UploadAvatarUseCase uploadAvatarUseCase;

  // keeps the last fetched user available to re-emit after a save,
  // so screens relying on ProfileSuccess don't lose the displayed data.
  UserEntity? _currentUser;

  // exposed so ProfileViewBody can read the last known user during
  // intermediate states (SavingStudentInfo, UpdatingPassword, etc.)
  UserEntity? get currentUser => _currentUser;

  ProfileCubit({
    required this.getMeUseCase,
    required this.saveStudentInfoUseCase,
    required this.updatePasswordUseCase,
    required this.uploadAvatarUseCase,
  }) : super(ProfileInitial());

  Future<void> getMe() async {
    emit(ProfileLoading());
    final result = await getMeUseCase.call();
    result.fold((failure) => emit(ProfileFailure(failure.message)), (user) {
      _currentUser = user;
      emit(ProfileSuccess(user));
    });
  }

  Future<void> saveStudentInfo({
    required String studySection,
    required String? scientificDepartment,
    required int governorateId,
    required double percentage,
    required int age,
  }) async {
    emit(SavingStudentInfo());
    final result = await saveStudentInfoUseCase.call(
      studySection: studySection,
      scientificDepartment: scientificDepartment,
      governorateId: governorateId,
      percentage: percentage,
      age: age,
    );
    result.fold((failure) => emit(SaveStudentInfoFailure(failure.message)), (
      _,
    ) async {
      emit(StudentInfoSaved());
      // refresh local user data so ProfileSuccess reflects the saved values
      await getMe();
    });
  }

  Future<void> updatePassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(UpdatingPassword());
    final result = await updatePasswordUseCase.call(
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    result.fold(
      (failure) => emit(UpdatePasswordFailure(failure.message)),
      (_) => emit(PasswordUpdated()),
    );
  }

  // No intermediate loading state is emitted here — uploadAvatar is used by
  // AvatarProfile which tracks its own local loading/error UI, and emitting
  // ProfileLoading() here would also hide the avatar in CustomHomeAppBar
  // (which listens to the same singleton cubit) while uploading.
  // Returns true on success after getMe() refreshes the new avatar URL.
  Future<bool> uploadAvatar(File image) async {
    final result = await uploadAvatarUseCase.call(image);
    var success = false;
    result.fold((failure) => success = false, (_) => success = true);
    if (success) await getMe();
    return success;
  }

  // clears tokens and redirects to LoginView — lives here because ProfileCubit
  // is the only GetIt singleton that owns user-session state, and AuthCubit
  // is not a singleton (created per-view in auth screens only).
  Future<void> logout() async {
    await Prefs.remove('token');
    await Prefs.remove('refresh_token');
    _currentUser = null;
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      LoginView.routeName,
      (route) => false,
    );
  }
}

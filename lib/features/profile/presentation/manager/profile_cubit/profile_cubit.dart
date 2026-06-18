import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/features/auth/domain/entities/user_entity.dart';
import 'package:uni/features/auth/domain/use_cases/get_me_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/save_student_info_use_case.dart';
import 'package:uni/features/auth/domain/use_cases/update_password_use_case.dart';

part 'profile_state.dart';

// Single cubit for profile, personal_data, and security screens —
// they all operate on the same "object" (the current user's data).
class ProfileCubit extends Cubit<ProfileState> {
  final GetMeUseCase getMeUseCase;
  final SaveStudentInfoUseCase saveStudentInfoUseCase;
  final UpdatePasswordUseCase updatePasswordUseCase;

  // keeps the last fetched user available to re-emit after a save,
  // so screens relying on ProfileSuccess don't lose the displayed data.
  UserEntity? _currentUser;

  ProfileCubit({
    required this.getMeUseCase,
    required this.saveStudentInfoUseCase,
    required this.updatePasswordUseCase,
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
    required String scientificDepartment,
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
}

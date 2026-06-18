part of 'profile_cubit.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileSuccess extends ProfileState {
  final UserEntity user;
  ProfileSuccess(this.user);
}

class ProfileFailure extends ProfileState {
  final String errMessage;
  ProfileFailure(this.errMessage);
}

// separate from the fetch states above — saving student info doesn't
// invalidate the currently displayed user data if it fails.
class SavingStudentInfo extends ProfileState {}

class StudentInfoSaved extends ProfileState {}

class SaveStudentInfoFailure extends ProfileState {
  final String errMessage;
  SaveStudentInfoFailure(this.errMessage);
}

// separate from the above too — updating the password is an independent action.
class UpdatingPassword extends ProfileState {}

class PasswordUpdated extends ProfileState {}

class UpdatePasswordFailure extends ProfileState {
  final String errMessage;
  UpdatePasswordFailure(this.errMessage);
}

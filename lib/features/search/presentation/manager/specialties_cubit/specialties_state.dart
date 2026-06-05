part of 'specialties_cubit.dart';

abstract class SpecialtiesState {}

class SpecialtiesInitial extends SpecialtiesState {}

class SpecialtiesLoading extends SpecialtiesState {}

class SpecialtiesSuccess extends SpecialtiesState {
  final List<String> specialties;
  
  SpecialtiesSuccess(this.specialties);
}

class SpecialtiesFailure extends SpecialtiesState {
  final String message;
  SpecialtiesFailure(this.message);
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/features/search/domain/use_cases/get_specialties_use_case.dart';

part 'specialties_state.dart';

class SpecialtiesCubit extends Cubit<SpecialtiesState> {
  final GetSpecialtiesUseCase getSpecialtiesUseCase;

  SpecialtiesCubit(this.getSpecialtiesUseCase) : super(SpecialtiesInitial());

  Future<void> getSpecialties() async {
    emit(SpecialtiesLoading());

    final result = await getSpecialtiesUseCase.call();

    result.fold(
      (failure) => emit(SpecialtiesFailure(failure.message)),
      (specialties) => emit(SpecialtiesSuccess(specialties)),
    );
  }
}

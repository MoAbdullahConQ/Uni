import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/features/browse/domain/use_cases/get_unis_use_case.dart';

part 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  final GetUnisUseCase getUnisUseCase;

  BrowseCubit(this.getUnisUseCase) : super(BrowseInitial());

  Future<void> getUnis() async {
    emit(BrowseLoading());

    final result = await getUnisUseCase.call();

    result.fold(
      (failure) => emit(BrowseFailure(failure.message)),
      (unis) => emit(BrowseSuccess(unis)),
    );
  }
}

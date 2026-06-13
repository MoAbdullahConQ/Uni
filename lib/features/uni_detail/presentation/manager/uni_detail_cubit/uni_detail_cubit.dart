import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/features/uni_detail/domain/use_cases/get_uni_detail_use_case.dart';
import 'package:uni/features/uni_detail/presentation/manager/uni_detail_cubit/uni_detail_state.dart';

class UniDetailCubit extends Cubit<UniDetailState> {
  final GetUniDetailUseCase getUniDetailUseCase;

  UniDetailCubit(this.getUniDetailUseCase) : super(UniDetailInitial());

  Future<void> getUniDetail(int id) async {
    emit(UniDetailLoading());
    final result = await getUniDetailUseCase(id);
    result.fold(
      (failure) => emit(UniDetailFailure(failure.message)),
      (uniDetail) => emit(UniDetailSuccess(uniDetail)),
    );
  }
}

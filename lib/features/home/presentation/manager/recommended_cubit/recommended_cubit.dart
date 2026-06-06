import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/errors/custom_exceptions.dart';
import 'package:uni/features/home/data/data_sources/recommended_remote_data_source.dart';
import 'package:uni/features/home/domain/entities/recommended_uni_entity.dart';

part 'recommended_state.dart';

class RecommendedCubit extends Cubit<RecommendedState> {
  final RecommendedRemoteDataSource remoteDataSource;

  RecommendedCubit(this.remoteDataSource) : super(RecommendedInitial());

  Future<void> fetchRecommendedUnis() async {
    emit(RecommendedLoading());
    try {
      final unis = await remoteDataSource.getRecommendedUnis();
      if (unis.isEmpty) {
        emit(RecommendedEmpty());
      } else {
        emit(RecommendedSuccess(unis));
      }
    } on CustomExceptions catch (e) {
      emit(RecommendedFailure(e.message));
    }
  }
}

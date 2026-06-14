import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/entities/trending_uni_entity.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/core/data_sources/trending_remote_data_source.dart';

part 'trending_state.dart';

class TrendingCubit extends Cubit<TrendingState> {
  final TrendingRemoteDataSource remoteDataSource;

  TrendingCubit(this.remoteDataSource) : super(TrendingInitial());

  Future<void> fetchTrendingUnis() async {
    emit(TrendingLoading());

    try {
      final unis = await remoteDataSource.getTrendingUnis();
      if (unis.isEmpty) {
        emit(TrendingEmpty());
      } else {
        emit(TrendingSuccess(unis));
      }
    } on DioException catch (e) {
      emit(TrendingFailure(ServerFailure.fromDioError(e).message));
    }
  }
}

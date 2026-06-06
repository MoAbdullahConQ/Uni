import 'package:dio/dio.dart';
import 'package:uni/core/entities/trending_uni_entity.dart';
import 'package:uni/core/errors/custom_exceptions.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/core/models/trending_uni_model/trending_uni_model.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';

abstract class TrendingRemoteDataSource {
  Future<List<TrendingUniEntity>> getTrendingUnis();
}

class TrendingRemoteDataSourceImpl implements TrendingRemoteDataSource {
  final ApiService apiService;

  TrendingRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<TrendingUniEntity>> getTrendingUnis() async {
    try {
      final response = await apiService.get(
        endpoint: BackendEndpoints.getTrendingUnis,
      );

      final List<dynamic> list = response['data'];

      return list
          .map((e) => TrendingUniModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw CustomExceptions(message: ServerFailure.fromDioError(e).message);
    }
  }
}

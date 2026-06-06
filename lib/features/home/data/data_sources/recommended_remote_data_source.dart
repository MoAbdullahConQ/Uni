import 'package:dio/dio.dart';
import 'package:uni/core/errors/custom_exceptions.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';
import 'package:uni/features/home/data/models/recommended_uni_model.dart';
import 'package:uni/features/home/domain/entities/recommended_uni_entity.dart';

abstract class RecommendedRemoteDataSource {
  Future<List<RecommendedUniEntity>> getRecommendedUnis();
}

class RecommendedRemoteDataSourceImpl implements RecommendedRemoteDataSource {
  final ApiService apiService;

  RecommendedRemoteDataSourceImpl(this.apiService);

  @override

  Future<List<RecommendedUniEntity>> getRecommendedUnis() async {
    try {
      final response = await apiService.get(
        endpoint: BackendEndpoints.getTrendingUnis,
      );

      final List<dynamic> list = response['data'];

      return list
          .map((e) => RecommendedUniModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw CustomExceptions(message: ServerFailure.fromDioError(e).message);
    }
  }
}

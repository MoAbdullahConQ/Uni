import 'package:dio/dio.dart';
import 'package:uni/core/entities/unis_response.dart';
import 'package:uni/core/errors/custom_exceptions.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/core/helper_functions/get_unis_list.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';
import 'package:uni/features/search/domain/entities/search_filter_entity.dart';

abstract class SearchRemoteDataSource {
  Future<UnisResponse> search({
    required String query,
    required SearchFilterEntity filter,
    String? cursor,
  });
}

class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final ApiService apiService;

  SearchRemoteDataSourceImpl(this.apiService);

  @override
  Future<UnisResponse> search({
    required String query,
    required SearchFilterEntity filter,
    String? cursor,
  }) async {
    try {
      final bool filterByType = filter.selectedTypes.length == 1;

      final queryParams = <String, dynamic>{
        'per_page': 10,
        if (query.isNotEmpty) 'name': query,
        if (filterByType) 'type': filter.selectedTypes.first,
        'yearly_Expenses[0]': filter.minFees.toInt(),
        'yearly_Expenses[1]': filter.maxFees.toInt(),
        if (cursor != null) 'cursor': cursor,
      };

      final response = await apiService.get(
        endpoint: BackendEndpoints.search,
        queryParameters: queryParams,
      );

      final nextCursor = response['meta']?['next_cursor'] as String?;

      return UnisResponse(
        uniEntities: getUnisList(response),
        nextCursor: nextCursor,
      );
    } on DioException catch (e) {
      throw CustomExceptions(message: ServerFailure.fromDioError(e).message);
    }
  }
}

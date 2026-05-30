import 'package:dio/dio.dart';
import 'package:uni/core/errors/custom_exceptions.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/core/helper_functions/get_unis_list.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';
import 'package:uni/core/entities/unis_response.dart';

abstract class BrowseRemoteDataSource {
  Future<UnisResponse> getUnis({String? cursor});
}

class BrowseRemoteDataSourceImpl implements BrowseRemoteDataSource {
  final ApiService apiService;

  BrowseRemoteDataSourceImpl(this.apiService);

  @override
  Future<UnisResponse> getUnis({String? cursor}) async {
    try {
      var response = await apiService.get(
        endpoint: BackendEndpoints.getUniversities,
        queryParameters: {'per_page': 10, if (cursor != null) 'cursor': cursor},
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

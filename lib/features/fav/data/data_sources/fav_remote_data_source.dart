import 'package:uni/core/entities/unis_response.dart';
import 'package:uni/core/helper_functions/get_unis_list.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';

abstract class FavRemoteDataSource {
  Future<UnisResponse> getFavs({String? cursor});
  Future<void> addToFav(int universityId);
  Future<void> removeFromFav(int universityId);
}

class FavRemoteDataSourceImpl implements FavRemoteDataSource {
  final ApiService apiService;

  FavRemoteDataSourceImpl(this.apiService);

  @override
  Future<UnisResponse> getFavs({String? cursor}) async {
    var response = await apiService.get(
      endpoint: BackendEndpoints.getFavs,
      queryParameters: {'per_page': 10, if (cursor != null) 'cursor': cursor},
    );

    final nextCursor = response['meta']?['next_cursor'] as String?;

    return UnisResponse(
      uniEntities: getUnisList(response),
      nextCursor: nextCursor,
    );
  }

  @override
  Future<void> addToFav(int universityId) async {
    await apiService.post(
      endpoint: BackendEndpoints.addToFav,
      data: {'university_id': universityId},
    );
  }

  @override
  Future<void> removeFromFav(int universityId) async {
    await apiService.post(
      endpoint: BackendEndpoints.removeFromFav,
      data: {'university_id': universityId},
    );
  }
}

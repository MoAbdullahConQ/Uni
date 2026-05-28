import 'package:dio/dio.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/errors/custom_exeptions.dart';
import 'package:uni/core/helper_functions/get_unis_list.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';

abstract class BrowseRemoteDataSource {
  Future<List<UniEntity>> getUnis();
}

class BrowseRemoteDataSourceImpl implements BrowseRemoteDataSource {
  final ApiService apiService;

  BrowseRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<UniEntity>> getUnis() async {
    try {
      var response = await apiService.get(
        endpoint: BackendEndpoints.getUniversities,
      );

      return getUnisList(response);
    } on DioException catch (e) {
      throw CustomExeptions(
        message: e.response?.data['message'] ?? e.message ?? 'حدث خطأ ما',
      );
    }
  }
}

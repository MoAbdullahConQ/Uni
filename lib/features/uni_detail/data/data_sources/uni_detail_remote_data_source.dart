import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_detail_entity.dart';
import 'package:uni/features/uni_detail/data/models/uni_detail_model.dart';

abstract class UniDetailRemoteDataSource {
  Future<UniDetailEntity> getUniDetail(int id);
}

class UniDetailRemoteDataSourceImpl implements UniDetailRemoteDataSource {
  final ApiService apiService;

  UniDetailRemoteDataSourceImpl(this.apiService);

  @override
  Future<UniDetailEntity> getUniDetail(int id) async {
    final results = await Future.wait([
      apiService.get(endpoint: BackendEndpoints.getUniDetail(id)),
      apiService.get(endpoint: BackendEndpoints.getCollegesByUni(id)),
      apiService.get(endpoint: BackendEndpoints.getGraduatesByUni(id)),
      apiService.get(endpoint: BackendEndpoints.getUniLife(id)),
    ]);

    return UniDetailModel.fromJson(
      uniJson: results[0]['data'] as Map<String, dynamic>,
      collegesJson: results[1]['data'] as List<dynamic>,
      graduatesJson: results[2]['data'] as List<dynamic>,
      uniLifeJson: results[3]['data'] as List<dynamic>,
    );
  }
}

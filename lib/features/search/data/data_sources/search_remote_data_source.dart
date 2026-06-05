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

  Future<List<String>> getSpecialties();
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
        if (filterByType) 'type': _mapTypeToApi(filter.selectedTypes.first),
        for (int i = 0; i < filter.selectedSpecialties.length; i++)
          'speciality[$i]': filter.selectedSpecialties[i],
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

  @override
  Future<List<String>> getSpecialties() async {
    try {
      final response = await apiService.getList(
        endpoint: BackendEndpoints.getColleges,
      );

      final colleges = List<String>.from(response);

      final specialties = colleges
          .map(_mapCollegeToSpecialty)
          .whereType<String>()
          .toSet()
          .toList();

      return specialties;
    } on DioException catch (e) {
      throw CustomExceptions(message: ServerFailure.fromDioError(e).message);
    }
  }

  String _mapTypeToApi(String type) {
    switch (type) {
      case 'حكومية':
        return 'Public';
      case 'خاصة':
        return 'Private';
      default:
        return type;
    }
  }

  String? _mapCollegeToSpecialty(String college) {
    if (college.contains('طب الأسنان') || college.contains('طب الفم')) {
      return 'طب أسنان';
    }
    if (college.contains('طب')) return 'طب بشري';
    if (college.contains('هندسة')) return 'هندسة';
    if (college.contains('صيدلة')) return 'صيدلة';
    if (college.contains('حاسبات') ||
        college.contains('حاسب') ||
        college.contains('ذكاء اصطناعي') ||
        college.contains('معلومات')) {
      return 'حاسبات';
    }
    if (college.contains('إدارة') || college.contains('أعمال')) {
      return 'إدارة أعمال';
    }
    if (college.contains('فنون')) return 'فنون تطبيقية';
    if (college.contains('ألسن')) return 'ألسن';
    if (college.contains('إعلام')) return 'إعلام';
    return null;
  }
}

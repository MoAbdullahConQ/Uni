import 'package:dio/dio.dart';
import 'package:uni/core/services/shared_preferences_singleton.dart';
import 'package:uni/core/utils/backend_endpoints.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Accept'] = 'application/json';

          final token = Prefs.getString('token');
          if (token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
      ),
    );
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = await dio.get(
      '${BackendEndpoints.baseUrl}$endpoint',
      queryParameters: queryParameters,
    );
    return response.data;
  }

  Future<Map<String, dynamic>> post({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    var response = await dio.post(
      '${BackendEndpoints.baseUrl}$endpoint',
      data: data,
    );
    return response.data;
  }

  Future<List<dynamic>> getList({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) async {
    var response = await dio.get(
      '${BackendEndpoints.baseUrl}$endpoint',
      queryParameters: queryParameters,
    );
    return response.data;
  }
}

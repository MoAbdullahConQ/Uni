import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uni/core/utils/backend_endpoints.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

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
}

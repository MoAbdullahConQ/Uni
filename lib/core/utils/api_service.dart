import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uni/core/utils/backend_endpoints.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Map<String, dynamic>> get({required String endpoint}) async {
    var response = await _dio.get(
      '${BackendEndpoints.baseUrl}$endpoint',
    );
    return response.data;
  }
}

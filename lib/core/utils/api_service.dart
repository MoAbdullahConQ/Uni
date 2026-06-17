import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:uni/core/services/shared_preferences_singleton.dart';
import 'package:uni/core/utils/backend_endpoints.dart';
import 'package:uni/features/auth/presentation/views/login_view.dart';
import 'package:uni/main.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Accept'] = 'application/json';
          options.headers['Api-Key'] = dotenv.env['API_KEY'] ?? '';

          // only set token if not already set (e.g. postWithToken passes its own)
          if (!options.headers.keys.any(
            (k) => k.toLowerCase() == 'authorization',
          )) {
            final token = Prefs.getString('token');
            if (token.isNotEmpty) {
              options.headers['Authorization'] = 'Bearer $token';
            }
          }

          return handler.next(options);
        },
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            Prefs.remove('token');
            // message is passed as route arguments only — no global state.
            // each navigation owns its own message; nothing is left "pending".
            navigatorKey.currentState?.pushNamedAndRemoveUntil(
              LoginView.routeName,
              (route) => false,
              arguments: 'انتهت صلاحية جلستك، يرجى تسجيل الدخول مجدداً',
            );
          }
          return handler.next(error);
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

  Future<Map<String, dynamic>> patch({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    var response = await dio.patch(
      '${BackendEndpoints.baseUrl}$endpoint',
      data: data,
    );
    return response.data;
  }

  // Used with the temporary token in the forgot password flow
  Future<Map<String, dynamic>> postWithToken({
    required String endpoint,
    required String token,
    Map<String, dynamic>? data,
  }) async {
    var response = await dio.post(
      '${BackendEndpoints.baseUrl}$endpoint',
      data: data,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return response.data;
  }
}

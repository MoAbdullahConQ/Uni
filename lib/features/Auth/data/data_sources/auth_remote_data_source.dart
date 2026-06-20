import 'dart:io';

import 'package:dio/dio.dart';
import 'package:uni/core/services/shared_preferences_singleton.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';
import 'package:uni/features/auth/data/models/user_model.dart';
import 'package:uni/features/auth/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<void> login({required String email, required String password});
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  });
  Future<String> verifyOtp({required String otp, required String email});
  Future<void> forgetPassword({required String email});
  Future<void> resendOtp({required String email});
  Future<void> resetPassword({
    required String password,
    required String passwordConfirmation,
    required String tempToken,
  });
  Future<void> saveStudentInfo({
    required String studySection,
    required String? scientificDepartment,
    required int governorateId,
    required double percentage,
    required int age,
  });
  Future<void> updatePassword({
    required String password,
    required String passwordConfirmation,
  });
  Future<void> uploadAvatar(File image);
  Future<UserEntity> getMe();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  AuthRemoteDataSourceImpl(this.apiService);

  @override
  Future<void> login({required String email, required String password}) async {
    final response = await apiService.post(
      endpoint: BackendEndpoints.login,
      data: {'email': email, 'password': password},
    );
    // store the tokens in Prefs after login
    await Prefs.setString('token', response['data']['access_token']);
    await Prefs.setString('refresh_token', response['data']['refresh_token']);
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    await apiService.post(
      endpoint: BackendEndpoints.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
  }

  @override
  Future<String> verifyOtp({required String otp, required String email}) async {
    final response = await apiService.post(
      endpoint: BackendEndpoints.verifyOtp,
      data: {'otp': otp, 'email': email},
    );
    // store the access_token in the repo, which will decide whether to save it or pass it to the Cubit
    return response['data']['access_token'] as String;
  }

  @override
  Future<void> forgetPassword({required String email}) async {
    await apiService.post(
      endpoint: BackendEndpoints.forgetPassword,
      data: {'email': email},
    );
  }

  @override
  Future<void> resendOtp({required String email}) async {
    await apiService.post(
      endpoint: BackendEndpoints.resendOtp,
      data: {'email': email},
    );
  }

  @override
  Future<void> resetPassword({
    required String password,
    required String passwordConfirmation,
    required String tempToken,
  }) async {
    await apiService.postWithToken(
      endpoint: BackendEndpoints.resetPassword,
      token: tempToken,
      data: {
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
  }

  @override
  Future<void> saveStudentInfo({
    required String studySection,
    required String? scientificDepartment,
    required int governorateId,
    required double percentage,
    required int age,
  }) async {
    final data = <String, dynamic>{
      'study_section': studySection,
      'governorate_id': governorateId,
      'percentage': percentage,
      'age': age,
    };
    // backend rejects null/"" with a validation error — the key must be
    // omitted entirely when there's no scientific department (e.g. "أدبي")
    if (scientificDepartment != null && scientificDepartment.isNotEmpty) {
      data['scientific_department'] = scientificDepartment;
    }
    await apiService.post(
      endpoint: BackendEndpoints.saveStudentInfo,
      data: data,
    );
  }

  @override
  Future<void> updatePassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    await apiService.post(
      endpoint: BackendEndpoints.updatePassword,
      data: {
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
  }

  @override
  Future<void> uploadAvatar(File image) async {
    final formData = FormData.fromMap({
      'avatar': await MultipartFile.fromFile(image.path),
    });
    await apiService.postFormData(
      endpoint: BackendEndpoints.addAvatar,
      data: formData,
    );
  }

  @override
  Future<UserEntity> getMe() async {
    final response = await apiService.get(endpoint: BackendEndpoints.getMe);
    return UserModel.fromJson(response['data']['user']);
  }
}

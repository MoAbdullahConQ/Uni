import 'package:dio/dio.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';
import 'package:uni/features/faheem/data/models/faheem_message_model.dart';
import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';

abstract class FaheemRemoteDataSource {
  Future<ChatMessageEntity> sendMessage({required String message});
}

class FaheemRemoteDataSourceImpl implements FaheemRemoteDataSource {
  final ApiService apiService;

  FaheemRemoteDataSourceImpl(this.apiService);

  @override
  Future<ChatMessageEntity> sendMessage({required String message}) async {
    final response = await apiService.dio.post(
      '${BackendEndpoints.baseUrl}${BackendEndpoints.sendMessage}',
      data: FormData.fromMap({'message': message}),
    );
    return FaheemMessageModel.fromJson(response.data);
  }
}

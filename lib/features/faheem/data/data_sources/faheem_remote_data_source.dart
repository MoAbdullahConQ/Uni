import 'package:dio/dio.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';
import 'package:uni/features/faheem/data/models/conversation_details_model.dart';
import 'package:uni/features/faheem/data/models/conversation_model.dart';
import 'package:uni/features/faheem/data/models/faheem_message_model.dart';
import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';
import 'package:uni/features/faheem/domain/entities/conversation_details_entity.dart';
import 'package:uni/features/faheem/domain/entities/conversation_entity.dart';

abstract class FaheemRemoteDataSource {
  Future<ChatMessageEntity> sendMessage({
    required String message,
    int? conversationId,
  });
  Future<List<ConversationEntity>> getConversations();
  Future<ConversationDetailsEntity> getConversationMessages(int id);
}

class FaheemRemoteDataSourceImpl implements FaheemRemoteDataSource {
  final ApiService apiService;

  FaheemRemoteDataSourceImpl(this.apiService);

  @override
  Future<ChatMessageEntity> sendMessage({
    required String message,
    int? conversationId,
  }) async {
    final map = <String, dynamic>{'message': message};
    if (conversationId != null) map['conversation_id'] = conversationId;

    final response = await apiService.dio.post(
      '${BackendEndpoints.baseUrl}${BackendEndpoints.sendMessage}',
      data: FormData.fromMap(map),
    );
    return FaheemMessageModel.fromJson(response.data);
  }

  @override
  Future<List<ConversationEntity>> getConversations() async {
    final response = await apiService.dio.get(
      '${BackendEndpoints.baseUrl}${BackendEndpoints.getConversations}',
    );
    return (response.data as List<dynamic>)
        .map((e) => ConversationModel.fromJson(e))
        .toList();
  }

  @override

  Future<ConversationDetailsEntity> getConversationMessages(int id) async {
    final response = await apiService.dio.get(
      '${BackendEndpoints.baseUrl}${BackendEndpoints.getConversationMessages(id)}',
    );
    return ConversationDetailsModel.fromJson(response.data);
  }
}

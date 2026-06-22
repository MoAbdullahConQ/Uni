import 'package:uni/features/faheem/domain/entities/conversation_message_entity.dart';

class ConversationMessageModel extends ConversationMessageEntity {
  const ConversationMessageModel({
    required super.id,
    required super.conversationId,
    required super.message,
    required super.reply,
    required super.createdAt,
  });

  factory ConversationMessageModel.fromJson(Map<String, dynamic> json) {
    return ConversationMessageModel(
      id: json['id'],
      conversationId: json['conversation_id'],
      message: json['message'] ?? '',
      reply: json['reply'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

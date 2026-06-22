import 'package:uni/features/faheem/data/models/conversation_message_model.dart';
import 'package:uni/features/faheem/domain/entities/conversation_details_entity.dart';

class ConversationDetailsModel extends ConversationDetailsEntity {
  const ConversationDetailsModel({
    required super.id,
    required super.title,
    required super.messages,
  });

  factory ConversationDetailsModel.fromJson(Map<String, dynamic> json) {
    final msgs = (json['messages'] as List<dynamic>? ?? [])
        .map((m) => ConversationMessageModel.fromJson(m))
        .toList();
    return ConversationDetailsModel(
      id: json['id'],
      title: json['title'] ?? '',
      messages: msgs,
    );
  }
}

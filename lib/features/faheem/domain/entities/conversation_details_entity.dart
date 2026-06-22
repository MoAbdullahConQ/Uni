import 'package:uni/features/faheem/domain/entities/conversation_message_entity.dart';

class ConversationDetailsEntity {
  final int id;
  final String title;
  final List<ConversationMessageEntity> messages;

  const ConversationDetailsEntity({
    required this.id,
    required this.title,
    required this.messages,
  });
}

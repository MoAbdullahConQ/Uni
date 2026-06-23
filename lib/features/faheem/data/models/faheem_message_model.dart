import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';

class FaheemMessageModel extends ChatMessageEntity {
  final int? conversationId;

  const FaheemMessageModel({required super.text, this.conversationId})
    : super(sender: MessageSender.faheem);

  factory FaheemMessageModel.fromJson(Map<String, dynamic> json) {
    return FaheemMessageModel(
      text: json['response']?['content'] ?? '',
      conversationId: json['conversation_id'],
    );
  }
}

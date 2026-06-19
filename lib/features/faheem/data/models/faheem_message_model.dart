import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';

class FaheemMessageModel extends ChatMessageEntity {
  const FaheemMessageModel({required super.text})
      : super(sender: MessageSender.faheem);

  factory FaheemMessageModel.fromJson(Map<String, dynamic> json) {
    return FaheemMessageModel(
      text: json['content'] ?? '',
    );
  }
}

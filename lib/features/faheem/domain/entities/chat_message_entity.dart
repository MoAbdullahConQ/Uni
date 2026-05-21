enum MessageSender { user, faheem }

enum MessageContentType { text, uniCards }

class ChatMessageEntity {
  final String? text;
  final MessageSender sender;
  final MessageContentType contentType;
  final List<FaheemUniCardEntity>? uniCards;
  final bool isTyping; // typing indicator (...)

  const ChatMessageEntity({
    this.text,
    required this.sender,
    this.contentType = MessageContentType.text,
    this.uniCards,
    this.isTyping = false,
  });
}

class FaheemUniCardEntity {
  final String name;
  final String location;
  final String imagePath;
  final int matchPercent;

  const FaheemUniCardEntity({
    required this.name,
    required this.location,
    required this.imagePath,
    required this.matchPercent,
  });
}

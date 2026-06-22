class ConversationMessageEntity {
  final int id;
  final int conversationId;
  final String message;
  final String reply;
  final DateTime createdAt;

  const ConversationMessageEntity({
    required this.id,
    required this.conversationId,
    required this.message,
    required this.reply,
    required this.createdAt,
  });
}

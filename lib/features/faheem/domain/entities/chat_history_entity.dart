class ChatHistoryEntity {
  final String title;
  final String lastMessage;
  final String timeLabel; // '10:30 ص' | 'الإثنين' | 'الأحد'
  final String imagePath;

  const ChatHistoryEntity({
    required this.title,
    required this.lastMessage,
    required this.timeLabel,
    required this.imagePath,
  });
}

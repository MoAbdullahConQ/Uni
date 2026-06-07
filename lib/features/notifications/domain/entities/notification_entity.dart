class NotificationEntity {
  final int id;
  final String title;
  final String body;
  final String timeLabel;
  final bool isRead;
  final DateTime createdAt;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.timeLabel,
    required this.createdAt,
    this.isRead = false,
  });
}

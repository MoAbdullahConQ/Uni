enum NotificationType {
  update,   // تحديث مصاريف - icon refresh
  faheem,   // رد فهيم - robot image
  scholarship, // منحة دراسية - icon badge
  welcome,  // أهلاً بك - icon sparkle
  profile,  // استكمل بياناتك - icon person
}

class NotificationEntity {
  final String title;
  final String body;
  final String timeLabel;   // 'منذ 10 د' | '10:30 ص' | 'الثلاثاء'
  final NotificationType type;
  final bool isRead;

  const NotificationEntity({
    required this.title,
    required this.body,
    required this.timeLabel,
    required this.type,
    this.isRead = false,
  });
}

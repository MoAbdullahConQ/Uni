import 'package:uni/features/notifications/domain/entities/notification_entity.dart';

class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.timeLabel,
    required super.createdAt,
    super.isRead = false,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final createdAt = DateTime.parse(json['created_at']);
    return NotificationModel(
      id: json['id'],
      title: json['title'] ?? '',
      body: json['message'] ?? '',
      timeLabel: _formatTimeLabel(createdAt),
      isRead: json['read_status'].toString() == 'true',
      createdAt: createdAt,
    );
  }

  static String _formatTimeLabel(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} د';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} ساعة';

    const days = [
      'الأحد',
      'الإثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
    ];
    if (diff.inDays < 7) return days[date.weekday % 7];

    return '${date.day}/${date.month}';
  }
}

import 'package:uni/features/notifications/domain/entities/notification_entity.dart';

class NotificationsResponse {
  final List<NotificationEntity> notifications;
  final String? nextCursor;

  const NotificationsResponse({required this.notifications, this.nextCursor});
}

import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationsRepo {
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({String? cursor});
  Future<Either<Failure, void>> markAsRead(int notificationId);
  Future<Either<Failure, void>> markAllAsRead();
}

import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/notifications/domain/entities/notifications_response.dart';

abstract class NotificationsRepo {
  Future<Either<Failure, NotificationsResponse>> getNotifications({
    String? cursor,
  });
  Future<Either<Failure, int>> getUnreadCount();
  Future<Either<Failure, void>> markAsRead(int notificationId);
  Future<Either<Failure, void>> markAllAsRead();
}

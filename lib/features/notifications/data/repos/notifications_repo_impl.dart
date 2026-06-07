import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/custom_exceptions.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/notifications/data/data_sources/notifications_remote_data_source.dart';
import 'package:uni/features/notifications/domain/entities/notification_entity.dart';
import 'package:uni/features/notifications/domain/repos/notifications_repo.dart';

class NotificationsRepoImpl implements NotificationsRepo {
  final NotificationsRemoteDataSource remoteDataSource;

  NotificationsRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    String? cursor,
  }) async {
    try {
      final notifications = await remoteDataSource.getNotifications(
        cursor: cursor,
      );
      return right(notifications);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(int notificationId) async {
    try {
      await remoteDataSource.markAsRead(notificationId);
      return right(null);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    try {
      await remoteDataSource.markAllAsRead();
      return right(null);
    } on CustomExceptions catch (e) {
      return left(ServerFailure(e.message));
    }
  }
}

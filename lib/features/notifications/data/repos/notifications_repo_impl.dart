import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/notifications/data/data_sources/notifications_remote_data_source.dart';
import 'package:uni/features/notifications/domain/entities/notifications_response.dart';
import 'package:uni/features/notifications/domain/repos/notifications_repo.dart';

class NotificationsRepoImpl implements NotificationsRepo {
  final NotificationsRemoteDataSource remoteDataSource;

  NotificationsRepoImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, NotificationsResponse>> getNotifications({
    String? cursor,
  }) async {
    try {
      final result = await remoteDataSource.getNotifications(cursor: cursor);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, int>> getUnreadCount() async {
    try {
      final count = await remoteDataSource.getUnreadCount();
      return right(count);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(int notificationId) async {
    try {
      await remoteDataSource.markAsRead(notificationId);
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead() async {
    try {
      await remoteDataSource.markAllAsRead();
      return right(null);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}

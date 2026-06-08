import 'package:dio/dio.dart';
import 'package:uni/core/errors/custom_exceptions.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';
import 'package:uni/features/notifications/data/models/notification_model.dart';
import 'package:uni/features/notifications/domain/entities/notifications_response.dart';

abstract class NotificationsRemoteDataSource {
  Future<NotificationsResponse> getNotifications({String? cursor});
  Future<void> markAsRead(int notificationId);
  Future<void> markAllAsRead();
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final ApiService apiService;

  NotificationsRemoteDataSourceImpl(this.apiService);

  @override
  Future<NotificationsResponse> getNotifications({String? cursor}) async {
    try {
      final response = await apiService.get(
        endpoint: BackendEndpoints.getNotifications,
        queryParameters: {'per_page': 10, if (cursor != null) 'cursor': cursor},
      );

      final notifications = (response['data'] as List)
          .map((json) => NotificationModel.fromJson(json))
          .toList();

      final nextCursor = response['meta']['next_cursor'] as String?;

      return NotificationsResponse(
        notifications: notifications,
        nextCursor: nextCursor,
      );
    } on DioException catch (e) {
      throw CustomExceptions(message: ServerFailure.fromDioError(e).message);
    }
  }

  @override
  Future<void> markAsRead(int notificationId) async {
    try {
      await apiService.patch(
        endpoint: BackendEndpoints.markNotificationAsRead(notificationId),
      );
    } on DioException catch (e) {
      throw CustomExceptions(message: ServerFailure.fromDioError(e).message);
    }
  }

  @override
  Future<void> markAllAsRead() async {
    try {
      await apiService.patch(
        endpoint: BackendEndpoints.markAllNotificationsAsRead,
      );
    } on DioException catch (e) {
      throw CustomExceptions(message: ServerFailure.fromDioError(e).message);
    }
  }
}

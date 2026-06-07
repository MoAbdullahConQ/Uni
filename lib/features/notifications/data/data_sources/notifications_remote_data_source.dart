import 'package:dio/dio.dart';
import 'package:uni/core/errors/custom_exceptions.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';
import 'package:uni/features/notifications/data/models/notification_model.dart';
import 'package:uni/features/notifications/domain/entities/notification_entity.dart';

abstract class NotificationsRemoteDataSource {
  Future<List<NotificationEntity>> getNotifications({String? cursor});
  Future<void> markAsRead(int notificationId);
  Future<void> markAllAsRead();
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final ApiService apiService;

  NotificationsRemoteDataSourceImpl(this.apiService);

  @override
  Future<List<NotificationEntity>> getNotifications({String? cursor}) async {
    try {
      final response = await apiService.get(
        endpoint: BackendEndpoints.getNotifications,
        queryParameters: {'per_page': 10, if (cursor != null) 'cursor': cursor},
      );

      return (response['data'] as List)
          .map((json) => NotificationModel.fromJson(json))
          .toList();
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

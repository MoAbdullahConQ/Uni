import 'package:uni/core/utils/api_service.dart';
import 'package:uni/core/utils/backend_endpoints.dart';
import 'package:uni/features/notifications/data/models/notification_model.dart';
import 'package:uni/features/notifications/domain/entities/notifications_response.dart';

abstract class NotificationsRemoteDataSource {
  Future<NotificationsResponse> getNotifications({String? cursor});
  Future<int> getUnreadCount();
  Future<void> markAsRead(int notificationId);
  Future<void> markAllAsRead();
}

class NotificationsRemoteDataSourceImpl
    implements NotificationsRemoteDataSource {
  final ApiService apiService;

  NotificationsRemoteDataSourceImpl(this.apiService);

  @override
  Future<NotificationsResponse> getNotifications({String? cursor}) async {
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
  }

  @override
  Future<int> getUnreadCount() async {
    final response = await apiService.get(
      endpoint: BackendEndpoints.getUnreadNotificationsCount,
    );
    return response['data']['total'] as int;
  }

  @override
  Future<void> markAsRead(int notificationId) async {
    await apiService.patch(
      endpoint: BackendEndpoints.markNotificationAsRead(notificationId),
    );
  }

  @override
  Future<void> markAllAsRead() async {
    await apiService.patch(
      endpoint: BackendEndpoints.markAllNotificationsAsRead,
    );
  }
}

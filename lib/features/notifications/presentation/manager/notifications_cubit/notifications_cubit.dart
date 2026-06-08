import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/features/notifications/domain/entities/notification_entity.dart';
import 'package:uni/features/notifications/domain/use_cases/get_notifications_use_case.dart';
import 'package:uni/features/notifications/domain/use_cases/mark_all_notifications_as_read_use_case.dart';
import 'package:uni/features/notifications/domain/use_cases/mark_notification_as_read_use_case.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkNotificationAsReadUseCase markAsReadUseCase;
  final MarkAllNotificationsAsReadUseCase markAllAsReadUseCase;

  NotificationsCubit({
    required this.getNotificationsUseCase,
    required this.markAsReadUseCase,
    required this.markAllAsReadUseCase,
  }) : super(NotificationsInitial());

  List<NotificationEntity> _allNotifications = [];

  Future<void> getNotifications() async {
    emit(NotificationsLoading());

    final result = await getNotificationsUseCase.call();

    result.fold((failure) => emit(NotificationsFailure(failure.message)), (
      notifications,
    ) {
      _allNotifications = notifications;
      _emitGrouped();
    });
  }

  Future<void> markAsRead(int notificationId) async {
    final result = await markAsReadUseCase.call(notificationId);
    result.fold(
      (failure) => emit(NotificationsActionFailure(failure.message)),
      (_) {
        _allNotifications = _allNotifications.map((n) {
          if (n.id == notificationId) {
            return NotificationEntity(
              id: n.id,
              title: n.title,
              body: n.body,
              timeLabel: n.timeLabel,
              createdAt: n.createdAt,
              isRead: true,
            );
          }
          return n;
        }).toList();
        _emitGrouped();
      },
    );
  }

  Future<void> markAllAsRead() async {
    final result = await markAllAsReadUseCase.call();
    result.fold(
      (failure) => emit(NotificationsActionFailure(failure.message)),
      (_) {
        _allNotifications = _allNotifications.map((n) {
          return NotificationEntity(
            id: n.id,
            title: n.title,
            body: n.body,
            timeLabel: n.timeLabel,
            createdAt: n.createdAt,
            isRead: true,
          );
        }).toList();
        _emitGrouped();
      },
    );
  }

  void _emitGrouped() {
    final now = DateTime.now();
    final today = <NotificationEntity>[];
    final yesterday = <NotificationEntity>[];
    final thisWeek = <NotificationEntity>[];
    final older = <NotificationEntity>[];

    for (final n in _allNotifications) {
      final diff = now.difference(n.createdAt);
      if (diff.inDays == 0) {
        today.add(n);
      } else if (diff.inDays == 1) {
        yesterday.add(n);
      } else if (diff.inDays <= 7) {
        thisWeek.add(n);
      } else {
        older.add(n);
      }
    }

    // sort each group by createdAt descending
    today.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    yesterday.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    thisWeek.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    older.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    emit(
      NotificationsSuccess(
        today: today,
        yesterday: yesterday,
        thisWeek: thisWeek,
        older: older,
      ),
    );
  }
}

part of 'notifications_cubit.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsSuccess extends NotificationsState {
  final List<NotificationEntity> today;
  final List<NotificationEntity> yesterday;
  final List<NotificationEntity> thisWeek;
  final List<NotificationEntity> older;

  NotificationsSuccess({
    required this.today,
    required this.yesterday,
    required this.thisWeek,
    required this.older,
  });
}

class NotificationsFailure extends NotificationsState {
  final String errMessage;
  
  NotificationsFailure(this.errMessage);
}

class NotificationsActionFailure extends NotificationsState {
  final String errMessage;
  NotificationsActionFailure(this.errMessage);
}

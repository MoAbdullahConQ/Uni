import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/features/notifications/domain/use_cases/get_notifications_use_case.dart';
import 'package:uni/features/notifications/domain/use_cases/mark_all_notifications_as_read_use_case.dart';
import 'package:uni/features/notifications/domain/use_cases/mark_notification_as_read_use_case.dart';
import 'package:uni/features/notifications/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:uni/features/notifications/presentation/views/widgets/notifications_view_body.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  static const routeName = 'notifications';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationsCubit(
        getNotificationsUseCase: getIt<GetNotificationsUseCase>(),
        markAsReadUseCase: getIt<MarkNotificationAsReadUseCase>(),
        markAllAsReadUseCase: getIt<MarkAllNotificationsAsReadUseCase>(),
      )..getNotifications(),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: NotificationsViewBody()),
      ),
    );
  }
}

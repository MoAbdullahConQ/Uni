import 'package:flutter/material.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/features/notifications/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:uni/features/notifications/presentation/views/widgets/notifications_view_body.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  static const routeName = 'notifications';

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  @override
  void initState() {
    super.initState();
    getIt<NotificationsCubit>().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: NotificationsViewBody()),
    );
  }
}

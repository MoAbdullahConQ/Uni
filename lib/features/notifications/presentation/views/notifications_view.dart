import 'package:flutter/material.dart';

import 'package:uni/features/notifications/presentation/views/widgets/notifications_view_body.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  static const routeName = 'notifications';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: NotificationsViewBody()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/helper_functions/getDummyGuideEntities.dart';
import 'package:uni/features/notifications/presentation/views/widgets/notification_group_section.dart';
import 'package:uni/features/notifications/presentation/views/widgets/notifications_app_bar.dart';

class NotificationsViewBody extends StatelessWidget {
  const NotificationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kTopPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App bar
            const NotificationsAppBar(),
            const SizedBox(height: 24),

            // Today
            NotificationGroupSection(
              label: 'اليوم',
              notifications: getDummyTodayNotifications(),
            ),
            const SizedBox(height: 24),

             // Yesterday
            NotificationGroupSection(
              label: 'الأمس',
              notifications: getDummyYesterdayNotifications(),
            ),
            const SizedBox(height: 24),

            // This week
            NotificationGroupSection(
              label: 'هذا الأسبوع',
              notifications: getDummyThisWeekNotifications(),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

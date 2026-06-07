import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/features/notifications/presentation/views/widgets/notification_group_section.dart';
import 'package:uni/features/notifications/presentation/views/widgets/notifications_app_bar.dart';

class NotificationsViewBody extends StatelessWidget {
  const NotificationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kTopPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App bar
            NotificationsAppBar(),
            SizedBox(height: 24),

            // Today
            NotificationGroupSection(
              label: 'اليوم',
              // notifications: getDummyTodayNotifications(),
              notifications: [],
            ),
            SizedBox(height: 24),

            // Yesterday
            NotificationGroupSection(
              label: 'الأمس',
              // notifications: getDummyYesterdayNotifications(),
              notifications: [],
            ),
            SizedBox(height: 24),

            // This week
            NotificationGroupSection(
              label: 'هذا الأسبوع',
              notifications: [],
              // notifications: getDummyThisWeekNotifications(),
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

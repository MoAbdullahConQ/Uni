import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
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
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/widgets/custom_error_widget.dart';
import 'package:uni/features/notifications/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:uni/features/notifications/presentation/views/widgets/notification_group_section.dart';
import 'package:uni/features/notifications/presentation/views/widgets/notifications_app_bar.dart';

class NotificationsViewBody extends StatelessWidget {
  const NotificationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        if (state is NotificationsFailure) {
          return CustomErrorWidget(message: state.errMessage);
        }

        if (state is NotificationsLoading || state is NotificationsInitial) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is NotificationsSuccess) {
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
                  if (state.today.isNotEmpty) ...[
                    NotificationGroupSection(
                      label: 'اليوم',
                      notifications: state.today,
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Yesterday
                  if (state.yesterday.isNotEmpty) ...[
                    NotificationGroupSection(
                      label: 'الأمس',
                      notifications: state.yesterday,
                    ),
                    const SizedBox(height: 24),
                  ],

                  if (state.thisWeek.isNotEmpty) ...[
                    NotificationGroupSection(
                      label: 'هذا الأسبوع',
                      notifications: state.thisWeek,
                    ),
                    const SizedBox(height: 24),
                  ],

                  if (state.older.isNotEmpty) ...[
                    NotificationGroupSection(
                      label: 'أقدم',
                      notifications: state.older,
                    ),
                    const SizedBox(height: 24),
                  ],

                  const SizedBox(height: 32),
                ],
              ),
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}

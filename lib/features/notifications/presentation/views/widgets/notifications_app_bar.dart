import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/back_button.dart';
import 'package:uni/features/notifications/presentation/manager/notifications_cubit/notifications_cubit.dart';

class NotificationsAppBar extends StatelessWidget {
  const NotificationsAppBar({super.key});

  bool _hasUnread(NotificationsState state) {
    if (state is! NotificationsSuccess) return false;
    return state.unreadCount > 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      buildWhen: (_, current) => current is! NotificationsActionFailure,
      builder: (context, state) {
        return Row(
          children: [
            // Back button
            const CustomBackButton(),

            const SizedBox(width: 16),

            // Title
            Text(
              'الإشعارات',
              style: TextStyles.bold20.copyWith(color: AppColors.primaryColor),
            ),

            const Spacer(),

            // mark all as read appears only if there are unread
            if (_hasUnread(state))
              GestureDetector(
                onTap: () => context.read<NotificationsCubit>().markAllAsRead(),
                child: Text(
                  'قراءة الكل (${(state as NotificationsSuccess).unreadCount})',
                  style: TextStyles.semiBold13.copyWith(
                    color: AppColors.lightPrimaryColor,
                  ),
                ),
              ),

            const SizedBox(width: 16),
          ],
        );
      },
    );
  }
}

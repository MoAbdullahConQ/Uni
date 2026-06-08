import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/notifications/domain/entities/notification_entity.dart';
import 'package:uni/features/notifications/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:uni/features/notifications/presentation/views/widgets/notification_card.dart';

class NotificationGroupSection extends StatelessWidget {
  final String label;
  final List<NotificationEntity> notifications;

  const NotificationGroupSection({
    super.key,
    required this.label,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Group label
        Text(
          label,
          style: TextStyles.semiBold13.copyWith(
            color: AppColors.subtitleColor.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 12),

        // Cards
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: notifications.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) => GestureDetector(
            onTap: () => context.read<NotificationsCubit>().markAsRead(
              notifications[i].id,
            ),
            child: NotificationCard(notificationEntity: notifications[i]),
          ),
        ),
      ],
    );
  }
}

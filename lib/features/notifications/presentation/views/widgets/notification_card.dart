import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/notifications/domain/entities/notification_entity.dart';
import 'package:uni/features/notifications/presentation/views/widgets/notification_icon_widget.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key, required this.notificationEntity});

  final NotificationEntity notificationEntity;

  @override
  Widget build(BuildContext context) {
    final isUnread = !notificationEntity.isRead;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isUnread ? AppColors.lightSecondaryColor : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isUnread
              ? AppColors.secondaryColor.withOpacity(0.4)
              : AppColors.borderColor,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 2,
            offset: Offset(0, 1),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 3,
            offset: Offset(0, 1),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          const NotificationIconWidget(),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Text(
                      notificationEntity.title,
                      textAlign: TextAlign.right,
                      style: TextStyles.bold14.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    // Time
                    Row(
                      children: [
                        if (isUnread)
                          Container(
                            width: 7,
                            height: 7,
                            margin: const EdgeInsets.only(left: 5, top: 2),
                            decoration: const BoxDecoration(
                              color: AppColors.lightPrimaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        Text(
                          notificationEntity.timeLabel,
                          style: TextStyles.regular11.copyWith(
                            color: AppColors.subtitleColor.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Body
                Text(
                  notificationEntity.body,
                  style: TextStyles.regular13.copyWith(
                    color: AppColors.subtitleColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

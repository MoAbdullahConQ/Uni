import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/features/notifications/domain/entities/notification_entity.dart';

class NotificationIconWidget extends StatelessWidget {
  // final NotificationType type;

  // const NotificationIconWidget({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.lightSecondaryColor,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderColor),
          ),
          // child: Center(child: _buildIcon()),
        ),
      ],
    );
  }

  // Widget _buildIcon() {
  //   switch (type) {
  //     case NotificationType.update:
  //       return const Icon(
  //         Icons.refresh_rounded,
  //         color: AppColors.primaryColor,
  //         size: 26,
  //       );
  //     case NotificationType.faheem:
  //       return ClipOval(
  //         child: SvgPicture.asset(
  //           Assets.imagesFaheemRobot,
  //           width:40 ,
  //           height:40,
  //           fit: BoxFit.cover,
  //         ),
  //       );
  //     case NotificationType.scholarship:
  //       return const Icon(
  //         Icons.workspace_premium_outlined,
  //         color: AppColors.primaryColor,
  //         size: 26,
  //       );
  //     case NotificationType.welcome:
  //       return const Icon(
  //         Icons.auto_awesome_rounded,
  //         color: AppColors.primaryColor,
  //         size: 26,
  //       );
  //     case NotificationType.profile:
  //       return const Icon(
  //         Icons.person_add_alt_1_outlined,
  //         color: AppColors.primaryColor,
  //         size: 26,
  //       );
  //   }
  // }

}

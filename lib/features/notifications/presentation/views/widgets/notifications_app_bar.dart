import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class NotificationsAppBar extends StatelessWidget {
  const NotificationsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Back button
        InkWell(
          customBorder: const CircleBorder(),
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          ),
        ),

        const SizedBox(width: 16),

        // Title
        Text(
          'الإشعارات',
          style: TextStyles.bold20.copyWith(color: AppColors.primaryColor),
        ),
      ],
    );
  }
}

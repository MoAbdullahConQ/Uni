import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/back_button.dart';

class NotificationsAppBar extends StatelessWidget {
  const NotificationsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}

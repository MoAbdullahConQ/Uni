import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.borderColor.withOpacity(.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back,
            size: 20,
            color: AppColors.primaryColor,
          ),
        ),
        const Spacer(flex: 2),
        Text(
          'الملف الشخصي',
          style: TextStyles.bold20.copyWith(color: AppColors.primaryColor),
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}

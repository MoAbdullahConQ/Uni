import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class ProfileLogoutButton extends StatelessWidget {
  const ProfileLogoutButton({super.key, this.onPressed});
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColors.red.withOpacity(.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.logout, color: AppColors.red, size: 20),
            const SizedBox(width: 8),
            Text(
              'تسجيل الخروج',
              style: TextStyles.bold16.copyWith(color: AppColors.red),
            ),
          ],
        ),
      ),
    );
  }
}

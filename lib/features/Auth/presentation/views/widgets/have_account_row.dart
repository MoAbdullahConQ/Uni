import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class HaveAccountRow extends StatelessWidget {
  const HaveAccountRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'لديك حساب بالفعل؟',
          style: TextStyles.regular16.copyWith(color: AppColors.subtitleColor),
        ),

        const SizedBox(width: 8),

        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Text(
            'تسجيل الدخول',
            style: TextStyles.regular16.copyWith(
              color: AppColors.primaryColor,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.secondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

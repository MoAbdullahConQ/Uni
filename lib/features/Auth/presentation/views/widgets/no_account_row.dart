import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/auth/presentation/views/sign_up_view.dart';

class NoAccountRow extends StatelessWidget {
  const NoAccountRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'ليس لديك حساب؟',
          style: TextStyles.regular16.copyWith(color: AppColors.subtitleColor),
        ),

        const SizedBox(width: 8),

        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpView.routeName),
          child: Text(
            'إنشاء حساب جديد',
            style: TextStyles.semiBold16.copyWith(
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

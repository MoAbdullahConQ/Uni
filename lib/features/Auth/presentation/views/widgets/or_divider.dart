import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.borderColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'أو تابع باستخدام',
            style: TextStyles.regular14.copyWith(
              color: AppColors.subtitleColor,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.borderColor)),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class VerifiedBadge extends StatelessWidget {
  const VerifiedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'تم التحقق بنجاح',
            style: TextStyles.semiBold14.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.check_circle_outline,
            size: 18,
            color: AppColors.primaryColor,
          ),
        ],
      ),
    );
  }
}

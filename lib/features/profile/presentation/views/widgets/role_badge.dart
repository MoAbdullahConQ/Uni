import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class RoleBadge extends StatelessWidget {
  const RoleBadge({super.key, required this.role});
  final String role;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.lightSecondaryColor,
        border: Border.all(color: AppColors.secondaryColor, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.school_outlined,
            size: 16,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 6),
          Text(
            role,
            style: TextStyles.bold13.copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const StatItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: AppColors.borderColor.withOpacity(.2),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.borderColor),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Expanded(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.secondaryColor.withOpacity(.5),
              ),
              child: Icon(icon, size: 20, color: AppColors.primaryColor),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyles.regular12.copyWith(
                color: AppColors.subtitleColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? iconBackgroundColor;
  final Color? iconColor;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconBackgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconBackgroundColor ?? const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 22, color: AppColors.primaryColor),
            ),

            const SizedBox(width: 12),

            // Label
            Text(
              label,
              style: TextStyles.bold14.copyWith(color: AppColors.primaryColor),
            ),

            const Spacer(),

            // Left: back arrow
            Icon(
              Icons.arrow_back_ios,
              textDirection: TextDirection.ltr,
              size: 18,
              color: AppColors.subtitleColor.withOpacity(.4),
            ),
          ],
        ),
      ),
    );
  }
}

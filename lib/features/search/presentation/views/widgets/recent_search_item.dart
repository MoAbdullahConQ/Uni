import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class RecentSearchItem extends StatelessWidget {
  const RecentSearchItem({
    super.key,
    required this.text,
    this.onTap,
    this.onDelete,
  });

  final String text;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Text + clock icon
            Row(
              children: [
                const Icon(
                  Icons.access_time_rounded,
                  size: 16,
                  color: AppColors.subtitleColor,
                ),
                const SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyles.semiBold14.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),

            // Delete
            GestureDetector(
              onTap: onDelete,
              child: const Icon(
                Icons.close_rounded,
                size: 18,
                color: AppColors.subtitleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

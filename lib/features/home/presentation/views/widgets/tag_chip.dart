import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class TagChip extends StatelessWidget {
  final String label;

  const TagChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.lightSecondaryColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.secondaryColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.regular11.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Icon(Icons.check, size: 12, color: AppColors.secondaryColor),
        ],
      ),
    );
  }
}

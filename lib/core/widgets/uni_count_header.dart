import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class UniCountHeader extends StatelessWidget {
  const UniCountHeader({super.key, required this.count, required this.label});

  final int count;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Count - right side
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'عندك ',
                style: TextStyles.semiBold13.copyWith(
                  color: AppColors.primaryColor.withOpacity(.6),
                ),
              ),
              TextSpan(
                text: '$count $label',
                style: TextStyles.bold14.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),

        // Sort button - left side
        // TODO: create sort
        Row(
          children: [
            Text(
              'الترتيب حسب',
              style: TextStyles.semiBold13.copyWith(
                color: AppColors.primaryColor.withOpacity(.6),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.subtitleColor,
            ),
          ],
        ),
      ],
    );
  }
}

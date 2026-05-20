import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';

class FilterButtonBadge extends StatelessWidget {
  const FilterButtonBadge({
    super.key,
    required this.onFilterTap,
    required this.activeFiltersCount,
  });

  final VoidCallback? onFilterTap;
  final int activeFiltersCount;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onFilterTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 8),
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(Assets.imagesFilter, height: 24),
            ),
          ),

          // Badge
          if (activeFiltersCount > 0)
            Positioned(
              top: -6,
              right: -6,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    '$activeFiltersCount',
                    style: TextStyles.bold11.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

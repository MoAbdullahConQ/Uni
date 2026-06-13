import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_faculty_entity.dart';

class FacultyItemHeader extends StatelessWidget {
  const FacultyItemHeader({
    super.key,
    required this.uniFacultyEntity,
    required this.isExpanded,
    required this.onTap,
  });

  final UniFacultyEntity uniFacultyEntity;
  final bool isExpanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isExpanded ? 0 : 16),
            bottomRight: Radius.circular(isExpanded ? 0 : 16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Name + icon + fees
            Row(
              //  crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon
                AnimatedContainer(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.symmetric(vertical: isExpanded ? 0 : 6),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isExpanded
                        ? AppColors.lightSecondaryColor
                        : AppColors.borderColor.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  // child: Icon(
                  //   uniFacultyEntity.icon,
                  //   size: 20,
                  //   color: AppColors.primaryColor,
                  // ),
                ),
                const SizedBox(width: 12),
                // Name + fees
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      uniFacultyEntity.name,
                      style: TextStyles.bold18.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),

                    // Collapsed: show fees preview
                    if (!isExpanded)
                      Text(
                        'مصاريف تبدأ من ${uniFacultyEntity.minFees}',
                        style: TextStyles.regular12.copyWith(
                          color: AppColors.subtitleColor,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            AnimatedRotation(
              turns: isExpanded ? .5 : 0,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

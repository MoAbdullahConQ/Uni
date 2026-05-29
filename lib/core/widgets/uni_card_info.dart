import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/location_widget.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/widgets/rating.dart';
import 'package:uni/core/widgets/type_badge_widget.dart';

class UniCardInfo extends StatelessWidget {
  const UniCardInfo({
    super.key,
    required this.selectedFilterUniEntity,
    required this.onDelete,
  });

  final UniEntity selectedFilterUniEntity;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Rating + Type badge
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TypeBadgeWidget(type: selectedFilterUniEntity.type),
              const Spacer(),
              Rating(rating: selectedFilterUniEntity.rating),
            ],
          ),

          const SizedBox(height: 8),

          // Uni name
          Text(
            selectedFilterUniEntity.name,
            style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
          ),

          const SizedBox(height: 4),

          // Location
          LocationRow(location: selectedFilterUniEntity.location, iconSize: 13),

          const SizedBox(height: 12),

          // Delete icon + Fees
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Fees
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'التصنيف العالمي',
                    style: TextStyles.regular11.copyWith(
                      color: AppColors.subtitleColor.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    selectedFilterUniEntity.worldRanking.toString(),
                    style: TextStyles.bold14.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),

              // Delete button
              if (onDelete != null)
                GestureDetector(
                  onTap: onDelete,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF7F9FA),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: SvgPicture.asset(Assets.imagesDelete, height: 22),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

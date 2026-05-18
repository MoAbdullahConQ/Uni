import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/location_widget.dart';
import 'package:uni/features/fav/domain/entities/fav_uni_entity.dart';
import 'package:uni/features/fav/presentation/views/widgets/rating.dart';
import 'package:uni/core/widgets/type_badge_widget.dart';

class FavUniCardInfo extends StatelessWidget {
  const FavUniCardInfo({
    super.key,
    required this.selectedFilterFavUniEntity,
    required this.onDelete,
  });

  final FavUniEntity selectedFilterFavUniEntity;
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
              TypeBadgeWidget(type: selectedFilterFavUniEntity.type),
              const Spacer(),
              Rating(rating: selectedFilterFavUniEntity.rating),
            ],
          ),

          const SizedBox(height: 8),

          // Uni name
          Text(
            selectedFilterFavUniEntity.name,
            style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
          ),

          const SizedBox(height: 4),

          // Location
          LocationRow(
            location: selectedFilterFavUniEntity.location,
            iconSize: 13,
          ),

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
                    'متوسط المصاريف',
                    style: TextStyles.regular11.copyWith(
                      color: AppColors.subtitleColor.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    selectedFilterFavUniEntity.averageFees,
                    style: TextStyles.bold14.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),

              // Delete button
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

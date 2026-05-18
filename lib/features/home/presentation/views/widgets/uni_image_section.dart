import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/widgets/type_badge_widget.dart';
import 'package:uni/features/home/domain/entities/recommended_uni_entity.dart';

class UniImageSection extends StatelessWidget {
  const UniImageSection({super.key, required this.recommendedUniEntity});

  final RecommendedUniEntity recommendedUniEntity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // University Image
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(23)),
          child: Image.asset(
            recommendedUniEntity.imagePath,
            height: 130,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        // Bookmark Icon
        Positioned(
          top: 14,
          left: 14,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.bookmark_border,
              // size: 22,
              color: Colors.grey,
            ),
          ),
        ),

        Positioned(
          bottom: -10,
          left: 10,
          child: TypeBadgeWidget(type: recommendedUniEntity.type),
        ),

        // Logo
        Positioned(
          bottom: -20,
          right: 12,
          child: Container(
            width: 44,
            height: 44,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: AppColors.borderColor, width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowBlack.withOpacity(0.1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Image.asset(
              recommendedUniEntity.logoPath ?? Assets.imagesCairoUni,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}

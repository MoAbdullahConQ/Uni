import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/location_widget.dart';
import 'package:uni/features/home/domain/entities/recommended_uni_entity.dart';
import 'package:uni/features/home/presentation/views/widgets/tag_chip.dart';

class UniInfoSection extends StatelessWidget {
  const UniInfoSection({super.key, required this.recommendedUniEntity});

  final RecommendedUniEntity recommendedUniEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name
          Text(
            recommendedUniEntity.name,
            style: TextStyles.bold18.copyWith(
              color: AppColors.primaryColor,
              height: 1.56,
            ),
          ),

          const SizedBox(height: 6),

          // Location
          LocationRow(location: recommendedUniEntity.location, iconSize: 14),

          const SizedBox(height: 8),

          // Tags and CTA Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tags
              Expanded(
                child: ClipRect(
                  child: SizedBox(
                    height: 26, // ارتفاع سطر واحد بس
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 6,
                      runSpacing: 4,
                      children: recommendedUniEntity.tags
                          .map((tag) => TagChip(label: tag))
                          .toList(),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              // CTA Button
              SizedBox(
                height: 28,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                      side: const BorderSide(width: 0.20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                  ),
                  child: Text(
                    'خدلك بصة',
                    style: TextStyles.bold14.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

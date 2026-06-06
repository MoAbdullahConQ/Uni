import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/location_widget.dart';
import 'package:uni/features/home/domain/entities/recommended_uni_entity.dart';
import 'package:uni/features/home/presentation/views/widgets/uni_info_chip.dart';
import 'package:uni/features/uni_detail/presentation/views/uni_detail_view.dart';

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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 6),

          // Location
          LocationRow(location: recommendedUniEntity.location, iconSize: 14),

          const SizedBox(height: 8),

          // Rate + Students + CTA
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Rate chip
              UniInfoChip(
                icon: Icons.star_rounded,
                iconColor: const Color(0xFFFFC107),
                label: recommendedUniEntity.rate,
              ),
              const SizedBox(width: 6),
              // Students chip
              UniInfoChip(
                icon: Icons.people_alt_rounded,
                iconColor: AppColors.primaryColor,
                label:
                    '${_formatCount(recommendedUniEntity.studentsCount)} طالب',
              ),
              const Spacer(),
              // CTA Button
              SizedBox(
                height: 28,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      UniDetailView.routeName,
                      arguments: recommendedUniEntity.id,
                    );
                  },
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

  String _formatCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}

import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/home/domain/entities/trending_uni_entity.dart';

class TrendingUniCard extends StatelessWidget {
  final TrendingUniEntity trendingUniEntity;

  const TrendingUniCard({super.key, required this.trendingUniEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowBlack.withOpacity(0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          // Logo
          Container(
            width: 48,
            height: 48,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: AppColors.lightSecondaryColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor, width: 1.2),
            ),
            child: Center(
              child: trendingUniEntity.logoPath != null
                  ? Image.asset(
                      trendingUniEntity.logoPath!,
                      fit: BoxFit.contain,
                    )
                  : const Icon(Icons.school, color: AppColors.primaryColor),
            ),
          ),

          const SizedBox(width: 12),
          // Text + Badge
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                trendingUniEntity.name,
                style: TextStyles.bold13.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Text(
                  '+${trendingUniEntity.interestPercent}% اهتمام',
                  style: TextStyles.bold11.copyWith(
                    color: AppColors.secondaryColor,
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

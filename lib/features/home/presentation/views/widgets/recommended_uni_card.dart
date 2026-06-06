import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/features/home/domain/entities/recommended_uni_entity.dart';
import 'package:uni/features/home/presentation/views/widgets/uni_image_section.dart';
import 'package:uni/features/home/presentation/views/widgets/uni_info_section.dart';

class RecommendedUniCard extends StatelessWidget {
  final RecommendedUniEntity recommendedUniEntity;

  const RecommendedUniCard({super.key, required this.recommendedUniEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowBlack.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 0),
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Image Section ──
          UniImageSection(recommendedUniEntity: recommendedUniEntity),
          const SizedBox(height: 32),

          // ── Info Section ──
          UniInfoSection(recommendedUniEntity: recommendedUniEntity),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

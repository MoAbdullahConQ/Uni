import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/home/domain/entities/trending_uni_entity.dart';
import 'package:uni/features/home/presentation/views/widgets/trending_uni_card.dart';

class TrendingUnisSection extends StatelessWidget {
  const TrendingUnisSection({super.key});

  @override
  Widget build(BuildContext context) {
    final universities = [
      TrendingUniEntity(
        name: 'الجامعه الامريكية',
        interestPercent: 15,
        logoPath: Assets.imagesCairoUni,
      ),
      TrendingUniEntity(
        name: 'الجامعة الألمانية',
        interestPercent: 15,
        logoPath: null,
      ),
      TrendingUniEntity(
        name: 'الجامعه الامريكية',
        interestPercent: 15,
        logoPath: Assets.imagesCairoUni,
      ),
    ];

    return Column(
      children: [
        // Header
        Row(
          children: [
            Text(
              'الجامعات التريند',
              textAlign: TextAlign.right,
              style: TextStyles.bold18.copyWith(color: AppColors.primaryColor),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.trending_up,
              textDirection: TextDirection.ltr,
              color: AppColors.secondaryColor,
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Horizontal List
        SizedBox(
          height: 85,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 6),
            itemCount: universities.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              return TrendingUniCard(trendingUniEntity: universities[index]);
            },
          ),
        ),
      ],
    );
  }
}

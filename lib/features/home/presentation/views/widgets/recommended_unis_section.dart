import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/home/domain/entities/recommended_uni_entity.dart';
import 'package:uni/features/home/presentation/views/widgets/recommended_uni_card.dart';

class RecommendedUnisSection extends StatelessWidget {
  const RecommendedUnisSection({super.key});

  static const List<RecommendedUniEntity> universities = [
    RecommendedUniEntity(
      name: 'جامعة الزقازيق',
      imagePath: Assets.imagesUniPic,
      location: 'القاهرة الجديدة',
      logoPath: Assets.imagesZagIcon,
      tags: ['حاسبات', 'طب', 'هندسة'],
      type: 'خاصة',
    ),
    RecommendedUniEntity(
      name: 'الجامعة الألمانية',
      imagePath: Assets.imagesUniPic,
      location: 'العبور',
      logoPath: null,
      tags: ['هندسة'],
      type: 'معهد عالي',
    ),
    RecommendedUniEntity(
      name: 'الجامعة الألمانية',
      imagePath: Assets.imagesUniPic,
      location: 'العبور',
      logoPath: null,
      tags: ['هندسة'],
      type: 'حكومية',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          ' ترشيحات تناسبك ✨',
          style: TextStyles.bold18.copyWith(
            color: AppColors.primaryColor,
            height: 1.56,
          ),
        ),

        const SizedBox(height: 12),

        // Horizontal List
        SizedBox(
          height: 270,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            itemCount: universities.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) =>
                RecommendedUniCard(recommendedUniEntity: universities[index]),
          ),
        ),
      ],
    );
  }
}

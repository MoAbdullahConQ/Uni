import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/home/domain/entities/guide_video_entity.dart';
import 'package:uni/features/home/presentation/views/widgets/guide_video_card.dart';

class GuideVideoSection extends StatelessWidget {
  const GuideVideoSection({super.key});

  static const GuideVideoEntity guideVideoEntity = GuideVideoEntity(
    title: 'إزاي تختار كليتك بناءً على سوق العمل في 2024؟',
    description: 'دليلك الشامل لمعرفة التخصصات المطلوبة وأفضل الجامعات.',
    thumbnailPath: Assets.imagesVideoThumb,
    duration: '03:42 / 12:45',
    views: 12,
    timeAgo: 'منذ يومين',
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        GestureDetector(
          onTap: () {
            // TODO: Navigate to guide videos page
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'جديد دليلك الجامعي 🗞️',
                  style: TextStyles.bold18.copyWith(
                    color: AppColors.primaryColor,
                    height: 1.56,
                  ),
                ),
                Text(
                  'الذهاب للدليل',
                  style: TextStyles.bold11.copyWith(
                    color: AppColors.subtitleColor,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        const GuideVideoCard(guideVideoEntity: guideVideoEntity),
      ],
    );
  }
}

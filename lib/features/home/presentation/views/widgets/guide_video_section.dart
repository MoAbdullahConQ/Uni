import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/guide_section_header.dart';
import 'package:uni/core/widgets/guide_video_card.dart';
import 'package:uni/core/helper_functions/getDummyGuideEntities.dart';

class GuideVideoSection extends StatelessWidget {
  const GuideVideoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        GuideSectionHeader(
          title: 'جديد دليلك الجامعي 🗞️',
          titleStyle: TextStyles.bold18.copyWith(
            color: AppColors.primaryColor,
            height: 1.56,
          ),
          subTitle: 'الذهاب للدليل',
          subTitleStyle: TextStyles.bold11.copyWith(
            color: AppColors.subtitleColor,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 16),

        GuideVideoCard(guideVideoEntity: getDummyGuideVideoEntities().first),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/helper_functions/getDummyGuideEntities.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/guide_section_header.dart';
import 'package:uni/core/widgets/guide_video_card.dart';

class GuideVideosViewBody extends StatelessWidget {
  const GuideVideosViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 28),

            GuideSectionHeader(
              title: 'شاهد وتعلّم',
              titleStyle: TextStyles.bold18.copyWith(
                color: AppColors.primaryColor,
              ),
              subTitle: '',
            ),
            const SizedBox(height: 16),

            // Videos list
            ...getDummyGuideVideoEntities().map(
              (video) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GuideVideoCard(guideVideoEntity: video),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

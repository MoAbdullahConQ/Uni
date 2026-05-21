import 'package:flutter/material.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/core/widgets/guide_section_header.dart';
import 'package:uni/core/widgets/guide_video_card.dart';

class FeaturedGuideVideoSection extends StatelessWidget {
  const FeaturedGuideVideoSection({
    super.key,
    required this.title,
    required this.subTitle,
    this.onTap,
    this.titleStyle,
    this.subTitleStyle,
  });
  final String title, subTitle;
  final VoidCallback? onTap;
  final TextStyle? titleStyle, subTitleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GuideSectionHeader(
          title: title,
          titleStyle: titleStyle,
          onTap: onTap,
          subTitle: subTitle,
          subTitleStyle: subTitleStyle,
        ),
        const SizedBox(height: 14),
        GuideVideoCard(guideVideoEntity: getDummyGuideVideoEntities().first),
      ],
    );
  }
}

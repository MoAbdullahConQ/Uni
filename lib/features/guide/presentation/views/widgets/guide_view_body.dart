import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/guide_video_card.dart';
import 'package:uni/core/helper_functions/getDummyGuideEntities.dart';
import 'package:uni/features/guide/presentation/views/widgets/featured_guide_podcasts_section.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_search_bar.dart';
import 'package:uni/core/widgets/guide_section_header.dart';

class GuideViewBody extends StatelessWidget {
  const GuideViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kTopPadding),

          // Title
          Text(
            'دليلك الجامعي 📚',
            style: TextStyles.bold24.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 16),

          // Search bar
          const GuideSearchBar(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 28),

                  // ── Videos section ──
                  GuideSectionHeader(
                    title: 'شاهد وتعلّم',
                    titleStyle: TextStyles.regular18.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const GuideVideosView(),
                      //   ),
                      // );
                    },
                    subTitle: 'عرض الكل',
                    subTitleStyle: TextStyles.regular13.copyWith(
                      color: AppColors.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 14),
                  GuideVideoCard(
                    guideVideoEntity: getDummyGuideVideoEntities().first,
                  ),

                  const SizedBox(height: 24),

                  // ── Podcasts section ──
                  GuideSectionHeader(
                    title: 'استمع وتعلّم 🎧',
                    titleStyle: TextStyles.regular18.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (_) => const GuideVideosView(),
                      //   ),
                      // );
                    },
                    subTitle: 'عرض الكل',
                    subTitleStyle: TextStyles.regular13.copyWith(
                      color: AppColors.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const FeaturedGuidePodcastsSection(),
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

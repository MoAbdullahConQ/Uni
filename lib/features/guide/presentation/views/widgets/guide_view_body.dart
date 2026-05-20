import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/helper_functions/getDummyGuideEntities.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/featured_guide_video_section.dart';
import 'package:uni/core/widgets/guide_section_header.dart';
import 'package:uni/features/guide/presentation/views/guide_videos_view.dart';
import 'package:uni/features/guide/presentation/views/widgets/featured_guide_podcasts_section.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_article_card.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_search_bar.dart';

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
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 28),

                  // ── Videos section ──
                  FeaturedGuideVideoSection(
                    title: 'شاهد وتعلّم',
                    titleStyle: TextStyles.regular18.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, GuideVideosView.routeName);
                    },
                    subTitle: 'عرض الكل',
                    subTitleStyle: TextStyles.regular13.copyWith(
                      color: AppColors.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // ── Podcasts section ──
                  const FeaturedGuidePodcastsSection(),
                  const SizedBox(height: 28),

                  // ── Articles section ──
                  GuideSectionHeader(
                    title: 'أحدث المقالات 📝',
                    titleStyle: TextStyles.regular18.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    onTap: () {
                      // TODO: navigate to all articles
                    },
                    subTitle: 'عرض الكل',
                    subTitleStyle: TextStyles.regular13.copyWith(
                      color: AppColors.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 14),
                  ...getDummyGuideArticleEntities().map((article) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GuideArticleCard(
                        guideArticleEntity: article,
                        onTap: () {
                          // TODO: navigate to article detail
                        },
                      ),
                    );
                  }),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_error_widget.dart';
import 'package:uni/core/widgets/featured_guide_video_section.dart';
import 'package:uni/core/widgets/search_bar_field.dart';
import 'package:uni/core/widgets/section_header_item.dart';
import 'package:uni/features/guide/presentation/manager/guide_cubit/guide_cubit.dart';
import 'package:uni/features/guide/presentation/views/guide_article_detail_view.dart';
import 'package:uni/features/guide/presentation/views/guide_articles_view.dart';
import 'package:uni/features/guide/presentation/views/guide_videos_view.dart';
import 'package:uni/features/guide/presentation/views/widgets/featured_guide_podcasts_section.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_article_card.dart';

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
          Text(
            'دليلك الجامعي 📚',
            style: TextStyles.bold24.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 16),
          const SearchBarField(
            hintText: 'ابحث عن مقالات، فيديوهات، بودكاست...',
            height: 60,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 28),

                  // Videos section
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

                  // Podcasts section
                  const FeaturedGuidePodcastsSection(),
                  const SizedBox(height: 28),

                  // Articles section header
                  SectionHeaderItem(
                    title: 'أحدث المقالات 📝',
                    titleStyle: TextStyles.regular18.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, GuideArticlesView.routeName);
                    },
                    subTitle: 'عرض الكل',
                    subTitleStyle: TextStyles.regular13.copyWith(
                      color: AppColors.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Articles from cubit
                  BlocBuilder<GuideCubit, GuideState>(
                    builder: (context, state) {
                      if (state is GuideLoading || state is GuideInitial) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is GuideFailure) {
                        return CustomErrorWidget(message: state.errMessage);
                      }

                      final articles = state is GuideSuccess
                          ? state.articles.take(2).toList()
                          : [];

                      return Column(
                        children: articles.map((article) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: GuideArticleCard(
                              guideArticleEntity: article,
                              onTap: () => Navigator.pushNamed(
                                context,
                                GuideArticleDetailView.routeName,
                                arguments: article,
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

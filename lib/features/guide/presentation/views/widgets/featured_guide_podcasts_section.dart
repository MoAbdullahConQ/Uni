import 'package:flutter/material.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/section_header_item.dart';
import 'package:uni/features/guide/presentation/views/guide_podcasts_view.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_podcast_card.dart';

class FeaturedGuidePodcastsSection extends StatelessWidget {
  const FeaturedGuidePodcastsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final podcasts = getDummyGuidePodcastEntities().take(5).toList();

    return Column(
      children: [
        SectionHeaderItem(
          title: 'استمع وتعلّم',
          titleStyle: TextStyles.regular18.copyWith(
            color: AppColors.primaryColor,
          ),
          onTap: () {
            Navigator.pushNamed(context, GuidePodcastsView.routeName);
          },
          subTitle: 'عرض الكل',
          subTitleStyle: TextStyles.regular13.copyWith(
            color: AppColors.subtitleColor,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          height: 230,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: podcasts.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (_, i) {
              return SizedBox(
                width: 160,
                child: GuidePodcastCard(guidePodcastEntity: podcasts[i]),
              );
            },
          ),
        ),
      ],
    );
  }
}

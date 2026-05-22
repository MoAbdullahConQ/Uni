import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/section_header_item.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_podcast_card.dart';

class GuidePodcastsViewBody extends StatelessWidget {
  const GuidePodcastsViewBody({super.key});

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

            SectionHeaderItem(
              title: 'استمع وتعلّم',
              titleStyle: TextStyles.bold18.copyWith(
                color: AppColors.primaryColor,
              ),
              subTitle: '',
            ),
            const SizedBox(height: 16),

            // Podcasts grid
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.75,
              ),
              itemCount: getDummyGuidePodcastEntities().length,
              itemBuilder: (_, i) => GuidePodcastCard(
                guidePodcastEntity: getDummyGuidePodcastEntities()[i],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

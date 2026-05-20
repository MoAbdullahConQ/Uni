import 'package:flutter/material.dart';
import 'package:uni/core/helper_functions/getDummyGuideEntities.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_podcast_card.dart';

class FeaturedGuidePodcastsSection extends StatelessWidget {
  const FeaturedGuidePodcastsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final podcasts = getDummyGuidePodcastEntities().take(5).toList();

    return SizedBox(
      height: 260,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: podcasts.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (_, i) {
          return GuidePodcastCard(guidePodcastEntity: podcasts[i]);
        },
      ),
    );
  }
}

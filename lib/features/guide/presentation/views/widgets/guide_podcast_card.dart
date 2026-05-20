import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/guide/domain/entities/guide_podcast_entity.dart';

class GuidePodcastCard extends StatelessWidget {
  final GuidePodcastEntity guidePodcastEntity;

  const GuidePodcastCard({super.key, required this.guidePodcastEntity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail + duration badge
          Stack(
            // fit: StackFit.expand,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  guidePodcastEntity.thumbnailPath,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              // Duration badge
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    guidePodcastEntity.duration,
                    style: TextStyles.bold11.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Title
          Text(
            guidePodcastEntity.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.regular14.copyWith(
              color: AppColors.primaryColor,
              height: 1.25,
            ),
          ),

          const SizedBox(height: 4),

          // Program name
          Text(
            guidePodcastEntity.programName,
            style: TextStyles.regular11.copyWith(
              color: AppColors.subtitleColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }
}

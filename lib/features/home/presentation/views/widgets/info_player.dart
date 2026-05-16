import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/home/domain/entities/guide_video_entity.dart';

class InfoPlayer extends StatelessWidget {
  const InfoPlayer({super.key, required this.guideVideoEntity});

  final GuideVideoEntity guideVideoEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            guideVideoEntity.title,
            style: TextStyles.regular16.copyWith(color: AppColors.primaryColor),
          ),

          const SizedBox(height: 4),

          // Description
          Text(
            guideVideoEntity.description,
            style: TextStyles.regular12.copyWith(
              color: AppColors.subtitleColor,
            ),
          ),

          const SizedBox(height: 8),

          // Views + Time
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.remove_red_eye_outlined,
                size: 14,
                color: AppColors.subtitleColor.withOpacity(0.8),
              ),
              const SizedBox(width: 4),
              Text(
                '${guideVideoEntity.views}K مشاهدة',
                style: TextStyles.semiBold11.copyWith(
                  color: AppColors.subtitleColor.withOpacity(0.8),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 3,
                height: 3,
                decoration: BoxDecoration(
                  color: AppColors.subtitleColor.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                guideVideoEntity.timeAgo,
                style: TextStyles.semiBold11.copyWith(
                  color: AppColors.subtitleColor.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

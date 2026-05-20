import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/entities/guide_video_entity.dart';
import 'package:uni/core/widgets/guide_video_player.dart';
import 'package:uni/core/widgets/guide_video_player_info.dart';

class GuideVideoCard extends StatelessWidget {
  final GuideVideoEntity guideVideoEntity;

  const GuideVideoCard({super.key, required this.guideVideoEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowBlack.withOpacity(0.1),
            blurRadius: 2,
            offset: const Offset(0, 1),
            spreadRadius: -1,
          ),
          const BoxShadow(
            color: AppColors.shadowBlack,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Video Player
          GuideVideoPlayer(entity: guideVideoEntity),

          // Info Player
          GuideVideoPlayerInfo(guideVideoEntity: guideVideoEntity),
        ],
      ),
    );
  }
}

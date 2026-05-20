import 'package:flutter/material.dart';
import 'package:uni/core/entities/guide_video_entity.dart';

class GuideVideoPlayer extends StatelessWidget {
  final GuideVideoEntity entity;

  const GuideVideoPlayer({super.key, required this.entity});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: Image.asset(
        entity.thumbnailPath,
        width: double.infinity,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
}

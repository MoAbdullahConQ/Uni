import 'package:flutter/material.dart';
import 'package:uni/features/guide/presentation/views/guide_videos_view_body.dart';

class GuideVideosView extends StatelessWidget {
  const GuideVideosView({super.key});

  static const String routeName = 'guide_video_view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: GuideVideosViewBody()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/features/guide/presentation/views/guide_podcasts_view_body.dart';

class GuidePodcastsView extends StatelessWidget {
  const GuidePodcastsView({super.key});

  static const String routeName = 'guide_podcasts_view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: GuidePodcastsViewBody()),
    );
  }
}

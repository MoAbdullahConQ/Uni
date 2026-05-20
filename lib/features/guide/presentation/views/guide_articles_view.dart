import 'package:flutter/material.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_articles_view_body.dart';

class GuideArticlesView extends StatelessWidget {
  const GuideArticlesView({super.key});

  static const String routeName = 'guide_article_view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: GuideArticlesViewBody()),
    );
  }
}

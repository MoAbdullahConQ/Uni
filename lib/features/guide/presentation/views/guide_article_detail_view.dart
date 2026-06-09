import 'package:flutter/material.dart';
import 'package:uni/features/guide/domain/entities/guide_article_entity.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_article_detail_view_body.dart';

class GuideArticleDetailView extends StatelessWidget {
  const GuideArticleDetailView({super.key, required this.article});

  static const String routeName = 'guide_article_detail_view';

  final GuideArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: GuideArticleDetailViewBody(article: article)),
    );
  }
}

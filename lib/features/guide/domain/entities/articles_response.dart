import 'package:uni/features/guide/domain/entities/guide_article_entity.dart';

class ArticlesResponse {
  final List<GuideArticleEntity> articles;
  final String? nextCursor;

  const ArticlesResponse({required this.articles, this.nextCursor});
}

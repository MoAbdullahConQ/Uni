import 'package:uni/features/guide/domain/entities/guide_article_entity.dart';

class GuideArticleModel extends GuideArticleEntity {
  const GuideArticleModel({
    required super.id,
    required super.title,
    required super.authorName,
    required super.authorAvatarUrl,
    required super.authorBio,
    required super.publishDate,
    required super.content,
  });

  factory GuideArticleModel.fromJson(Map<String, dynamic> json) {
    return GuideArticleModel(
      id: json['id'],
      title: json['title'] ?? '',
      authorName: json['author'] ?? '',
      authorAvatarUrl: json['author_avatar_url'] ?? '',
      authorBio: json['author_bio'] ?? '',
      publishDate: json['publication_date'] ?? '',
      content: json['content'] ?? '',
    );
  }
}

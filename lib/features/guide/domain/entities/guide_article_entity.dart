class GuideArticleEntity {
  final int id;
  final String title;
  final String authorName;
  final String authorAvatarUrl;
  final String authorBio;
  final String publishDate;
  final String content;

  const GuideArticleEntity({
    required this.id,
    required this.title,
    required this.authorName,
    required this.authorAvatarUrl,
    required this.authorBio,
    required this.publishDate,
    required this.content,
  });
}

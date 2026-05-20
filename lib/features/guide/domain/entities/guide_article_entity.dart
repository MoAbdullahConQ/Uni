class GuideArticleEntity {
  final String title;
  final String category;
  final String readTime;
  final String? imagePath;

  // Detail fields
  final String? authorName;
  final String? authorRole;
  final String? authorImagePath;
  final String? publishDate;
  final String? content;
  final List<String>? tags;

  const GuideArticleEntity({
    required this.title,
    required this.category,
    required this.readTime,
    this.imagePath,
    this.authorName,
    this.authorRole,
    this.authorImagePath,
    this.publishDate,
    this.content,
    this.tags,
  });
}

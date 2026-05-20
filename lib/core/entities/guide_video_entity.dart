class GuideVideoEntity {
  final String title;
  final String description;
  final String thumbnailPath;
  final String duration;
  final int views;
  final String timeAgo;

  const GuideVideoEntity({
    required this.title,
    required this.description,
    required this.thumbnailPath,
    required this.duration,
    required this.views,
    required this.timeAgo,
  });
}

class RecommendedUniEntity {
  final String name;
  final String location;
  final String imagePath;
  final String? logoPath;
  final List<String> tags;
  // final bool isPrivate;
   final String type; // 'خاصة' | 'حكومية' | 'معهد عالي'

  const RecommendedUniEntity({
    required this.name,
    required this.location,
    required this.imagePath,
    this.logoPath,
    required this.tags,
    required this.type,
    // this.isPrivate = false,
  });
}

class RecommendedUniEntity {
  final int id;
  final String name;
  final String location;
  final String imagePath;
  final String? logoPath;
  final String type;
  final String rate;
  final int studentsCount;

  const RecommendedUniEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.imagePath,
    this.logoPath,
    required this.type,
    required this.rate,
    required this.studentsCount,
  });
}

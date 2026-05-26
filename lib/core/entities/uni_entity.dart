class UniEntity {
  final int id;
  final String name;
  final String location;
  final String imagePath;
  final String type; // 'خاصة' | 'حكومية' | 'معهد عالي'
  final double rating;
  final int worldRanking;
  final bool isFav;

  const UniEntity({
    required this.id,
    required this.name,
    required this.location,
    required this.imagePath,
    required this.type,
    required this.rating,
    required this.worldRanking,
    this.isFav = false,
  });
}

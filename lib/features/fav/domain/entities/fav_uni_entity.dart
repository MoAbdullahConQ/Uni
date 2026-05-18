class FavUniEntity {
  final String name;
  final String location;
  final String imagePath;
  final String type; // 'خاصة' | 'حكومية' | 'معهد عالي'
  final double rating;
  final String averageFees;

  const FavUniEntity({
    required this.name,
    required this.location,
    required this.imagePath,
    required this.type,
    required this.rating,
    required this.averageFees,
  });
}

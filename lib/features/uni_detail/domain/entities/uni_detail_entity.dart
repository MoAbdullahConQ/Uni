class UniDetailEntity {
  final String name;
  final String type;
  final String address;
  final String heroImagePath;
  final String logoImagePath;
  final String about;
  final int studentsCount;
  final int foundedYear;
  final String worldRanking;

  const UniDetailEntity({
    required this.name,
    required this.type,
    required this.address,
    required this.heroImagePath,
    required this.logoImagePath,
    required this.about,
    required this.studentsCount,
    required this.foundedYear,
    required this.worldRanking,
  });
}

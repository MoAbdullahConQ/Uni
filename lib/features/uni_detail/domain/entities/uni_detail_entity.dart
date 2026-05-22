import 'package:uni/features/uni_detail/domain/entities/uni_alumni_entity.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_faculty_entity.dart';

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
  final List<UniFacultyEntity> uniFacultyEntities;
  final List<UniAlumniEntity> uniAlumniEntities;
  final List<String> campusPhotoPaths;

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
    required this.uniFacultyEntities,
    required this.uniAlumniEntities,
    required this.campusPhotoPaths,
  });
}

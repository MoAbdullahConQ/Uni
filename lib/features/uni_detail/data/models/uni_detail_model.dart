import 'package:uni/core/models/uni_model/uni_model.dart';
import 'package:uni/features/uni_detail/data/models/uni_alumni_model.dart';
import 'package:uni/features/uni_detail/data/models/uni_faculty_model.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_detail_entity.dart';

class UniDetailModel extends UniDetailEntity {
  const UniDetailModel({
    required super.id,
    required super.name,
    required super.type,
    required super.address,
    required super.heroImagePath,
    required super.logoImagePath,
    required super.about,
    required super.studentsCount,
    required super.foundedYear,
    required super.worldRanking,
    required super.website,
    required super.rate,
    required super.uniFacultyEntities,
    required super.uniAlumniEntities,
    required super.campusPhotoPaths,
  });

  factory UniDetailModel.fromJson({
    required Map<String, dynamic> uniJson,
    required List<dynamic> collegesJson,
    required List<dynamic> graduatesJson,
    required List<dynamic> uniLifeJson,
  }) {
    return UniDetailModel(
      id: uniJson['id'] as int,
      name: uniJson['name'] ?? '',
      type: _mapType(uniJson['type'] ?? ''),
      address: uniJson['location'] ?? '',
      heroImagePath: uniJson['background_image_url'] ?? '',
      logoImagePath: uniJson['avatar_url'] ?? '',
      about: uniJson['public_summary'] ?? '',
      studentsCount: (uniJson['students_count'] as num?)?.toInt() ?? 0,
      foundedYear: _parseYear(uniJson['foundation_date']),
      worldRanking: uniJson['world_ranking']?.toString() ?? '—',
      website: uniJson['website'] ?? '',
      rate: double.tryParse(uniJson['rate']?.toString() ?? '') ?? 0.0,
      uniFacultyEntities: collegesJson
          .map((e) => UniFacultyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      uniAlumniEntities: graduatesJson
          .map((e) => UniAlumniModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      campusPhotoPaths: uniLifeJson
          .map((e) => (e as Map<String, dynamic>)['image_url']?.toString() ?? '')
          .where((url) => url.isNotEmpty)
          .toList(),
    );
  }

  // "حكومي" → "حكومية" (نفس الباترن الموجود في UniModel)
  static String _mapType(String type) => UniModel.mapType(type);

  static int _parseYear(dynamic raw) {
    if (raw == null) return 0;
    return int.tryParse(raw.toString().split('-').first) ?? 0;
  }
}

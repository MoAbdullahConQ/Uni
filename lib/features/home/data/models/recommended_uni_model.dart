import 'package:uni/features/home/domain/entities/recommended_uni_entity.dart';

class RecommendedUniModel extends RecommendedUniEntity {
  RecommendedUniModel({
    required super.id,
    required super.name,
    required super.location,
    required super.imagePath,
    super.logoPath,
    required super.type,
    required super.rate,
    required super.studentsCount,
  });

  factory RecommendedUniModel.fromJson(Map<String, dynamic> json) {
    return RecommendedUniModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      imagePath: json['background_image_url'] ?? '',
      logoPath: json['avatar_url'] as String?,
      type: json['type'] ?? '',
      rate: json['rate'] ?? '0.00',
      studentsCount: json['students_count'] ?? 0,
    );
  }
}

import 'package:uni/features/uni_detail/domain/entities/uni_alumni_entity.dart';

class UniAlumniModel extends UniAlumniEntity {
  const UniAlumniModel({
    required super.id,
    required super.name,
    required super.imagePath,
    required super.graduationYear,
  });

  factory UniAlumniModel.fromJson(Map<String, dynamic> json) {
    return UniAlumniModel(
      id: json['id'] as int,
      name: json['popular_name'] ?? '',
      imagePath: json['avatar'] ?? '',
      graduationYear: _formatYear(json['graduation_year']),
    );
  }

  // "1934-06-10" → "دفعة 1934"
  static String _formatYear(dynamic raw) {
    if (raw == null) return '';
    final str = raw.toString();
    final year = str.split('-').first;
    return 'دفعة $year';
  }
}

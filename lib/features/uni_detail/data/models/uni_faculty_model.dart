import 'package:uni/features/uni_detail/domain/entities/uni_faculty_entity.dart';

class UniFacultyModel extends UniFacultyEntity {
  const UniFacultyModel({
    required super.id,
    required super.name,
    required super.location,
    required super.minFees,
    required super.minGrade,
    required super.requirements,
  });

  factory UniFacultyModel.fromJson(Map<String, dynamic> json) {
    return UniFacultyModel(
      id: json['id'] as int,
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      minFees: _formatFees(json['yearly_expenses']),
      minGrade: (json['min_percentage'] as num?)?.toDouble() ?? 0.0,
      requirements: _parseRequirements(json['admission_requirements']),
    );
  }

  static String _formatFees(dynamic fees) {
    if (fees == null) return '—';
    final amount = (fees as num).toInt();
    return '$amount EGP';
  }

  static List<String> _parseRequirements(dynamic raw) {
    if (raw == null) return [];
    if (raw is List) return raw.map((e) => e.toString()).toList();
    return [];
  }
}

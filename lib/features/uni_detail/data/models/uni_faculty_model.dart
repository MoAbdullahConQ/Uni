import 'package:flutter/material.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_faculty_entity.dart';

class UniFacultyModel extends UniFacultyEntity {
  const UniFacultyModel({
    required super.id,
    required super.name,
    required super.location,
    required super.minFees,
    required super.minGrade,
    required super.requirements,
    required super.icon,
  });

  factory UniFacultyModel.fromJson(Map<String, dynamic> json) {
    final name = json['name']?.toString() ?? '';
    return UniFacultyModel(
      id: json['id'] as int,
      name: name,
      location: json['location'] ?? '',
      minFees: _formatFees(json['yearly_expenses']),
      minGrade: (json['min_percentage'] as num?)?.toDouble() ?? 0.0,
      requirements: _parseRequirements(json['admission_requirements']),
      icon: _iconFromName(name),
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

  static IconData _iconFromName(String name) {
    if (name.contains('هندس')) return Icons.settings_outlined;
    if (name.contains('طب') ||
        name.contains('صيدل') ||
        name.contains('تمريض')) {
      return Icons.local_hospital_outlined;
    }
    if (name.contains('حاسب') ||
        name.contains('معلومات') ||
        name.contains('ذكاء')) {
      return Icons.computer_outlined;
    }
    if (name.contains('اقتصاد') ||
        name.contains('تجار') ||
        name.contains('إدار')) {
      return Icons.bar_chart_outlined;
    }
    if (name.contains('قانون') || name.contains('حقوق'))
      return Icons.gavel_outlined;
    if (name.contains('فنون') || name.contains('تصميم'))
      return Icons.brush_outlined;
    if (name.contains('علوم')) return Icons.science_outlined;
    if (name.contains('لغ') ||
        name.contains('آداب') ||
        name.contains('إعلام')) {
      return Icons.menu_book_outlined;
    }
    return Icons.school_outlined; // default
  }
}

import 'package:uni/features/auth/domain/entities/student_info_entity.dart';

class StudentInfoModel extends StudentInfoEntity {
  StudentInfoModel({
    required super.studySection,
    required super.scientificDepartment,
    required super.governorateId,
    required super.percentage,
    required super.age,
  });

  factory StudentInfoModel.fromJson(Map<String, dynamic> json) {
    return StudentInfoModel(
      studySection: json['study_section'] ?? '',
      scientificDepartment: json['scientific_department'] ?? '',
      governorateId: json['governorate_id'] ?? 0,
      percentage: (json['percentage'] as num?)?.toDouble() ?? 0,
      age: json['age'] ?? 0,
    );
  }
}

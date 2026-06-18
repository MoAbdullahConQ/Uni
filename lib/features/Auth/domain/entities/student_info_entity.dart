// Student academic info, nested under UserEntity.
// Null when the user hasn't completed the setup/student-info step yet.
class StudentInfoEntity {
  final String studySection; // 'science' | 'literature'
  final String scientificDepartment; // 'scientific' | 'Mathematics'
  final int governorateId;
  final double percentage;
  final int age;

  StudentInfoEntity({
    required this.studySection,
    required this.scientificDepartment,
    required this.governorateId,
    required this.percentage,
    required this.age,
  });
}

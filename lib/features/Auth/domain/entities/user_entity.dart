import 'package:uni/features/auth/domain/entities/student_info_entity.dart';

class UserEntity {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final String type;
  // null until the user completes student info (setup or personal_data screen)
  final StudentInfoEntity? studentInfo;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.type,
    this.studentInfo,
  });
}
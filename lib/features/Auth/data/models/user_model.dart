import 'package:uni/features/auth/data/models/student_info_model.dart';
import 'package:uni/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.avatar,
    required super.type,
    super.studentInfo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatar: json['avatar'],
      type: json['type'],
      studentInfo: json['student_info'] != null
          ? StudentInfoModel.fromJson(json['student_info'])
          : null,
    );
  }
}

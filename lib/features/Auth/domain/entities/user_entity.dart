class UserEntity {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final String type;

  UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.type,
  });
}

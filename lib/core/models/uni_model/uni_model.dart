import 'package:uni/core/entities/uni_entity.dart';

class UniModel extends UniEntity {
  final String? website;
  final String? avatar;
  final String? backgroundImage;
  final String? avatarUrl;
  final String? backgroundImageUrl;
  final String? publicSummary;
  final String? foundationDate;
  final int? studentsCount;
  final String? createdAt;

  const UniModel({
    required super.id,
    required super.name,
    required super.location,
    required super.imagePath,
    required super.type,
    required super.rating,
    required super.worldRanking,
    // super.isFav = false,

    this.website,
    this.avatar,
    this.backgroundImage,
    this.avatarUrl,
    this.backgroundImageUrl,
    this.publicSummary,
    this.foundationDate,
    this.studentsCount,
    this.createdAt,
  });

  factory UniModel.fromJson(Map<String, dynamic> json) {
    return UniModel(
      id: json['id'],
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      imagePath: json['background_image_url'] ?? '',
      type: mapType(json['type'] ?? ''),
      rating: double.tryParse(json['rate'].toString()) ?? 0.0,
      worldRanking: parseRanking(json['world_ranking']),
      // isFav: json['is_fav_for_me'].toString() == 'true',
      website: json['website'] as String?,
      avatar: json['avatar'] as String?,
      backgroundImage: json['background_image'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      backgroundImageUrl: json['background_image_url'] as String?,
      publicSummary: json['public_summary'] as String?,
      foundationDate: json['foundation_date'] as String?,
      studentsCount: json['students_count'] as int?,
      createdAt: json['created_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'location': location,
    'type': type,
    'rate': rating,
    // 'is_fav_for_me': isFav,
    'website': website,
    'avatar': avatar,
    'background_image': backgroundImage,
    'avatar_url': avatarUrl,
    'background_image_url': backgroundImageUrl,
    'public_summary': publicSummary,
    'world_ranking': worldRanking,
    'foundation_date': foundationDate,
    'students_count': studentsCount,
    'created_at': createdAt,
  };

  static String mapType(String type) {
    switch (type) {
      case 'حكومي':
        return 'حكومية';
      case 'خاص':
        return 'خاصة';
      default:
        return type;
    }
  }

  static int parseRanking(dynamic ranking) {
    if (ranking == null) return 0;
    final str = ranking.toString().replaceAll('"', '').trim();
    if (str.contains('-')) {
      return int.tryParse(str.split('-').first.trim()) ?? 0;
    }
    return int.tryParse(str) ?? 0;
  }
}

import 'package:uni/core/entities/uni_entity.dart';

class SearchUniModel extends UniEntity {
  const SearchUniModel({
    required super.id,
    required super.name,
    required super.location,
    required super.imagePath,
    required super.type,
    required super.rating,
    required super.worldRanking,
  });

  factory SearchUniModel.fromJson(Map<String, dynamic> json) {
    return SearchUniModel(
      id: json['id'] as int,
      name: json['university_name'] ?? '',
      location: json['location'] ?? '',
      imagePath: json['university_image'] ?? '',
      type: _mapType(json['university_type'] ?? ''),
      rating: double.tryParse(json['university_rate'].toString()) ?? 0.0,
      worldRanking: 0,
    );
  }

  static String _mapType(String type) {
    switch (type) {
      case 'حكومي':
        return 'حكومية';
      case 'خاص':
        return 'خاصة';
      default:
        return type;
    }
  }
}

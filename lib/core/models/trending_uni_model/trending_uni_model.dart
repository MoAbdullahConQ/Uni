import 'package:uni/core/entities/trending_uni_entity.dart';

class TrendingUniModel extends TrendingUniEntity {
  TrendingUniModel({
    required super.name,
    required super.worldRanking,
    super.logoPath,
  });

  factory TrendingUniModel.fromJson(Map<String, dynamic> json) {
    return TrendingUniModel(
      name: json['name'] ?? '',
      worldRanking: json['world_ranking']?.toString() ?? '-',
      logoPath: json['avatar_url'] as String?,
    );
  }
}

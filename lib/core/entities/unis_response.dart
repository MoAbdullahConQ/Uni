import 'package:uni/core/entities/uni_entity.dart';

class UnisResponse {
  final List<UniEntity> uniEntities;
  final String? nextCursor; // browse & fav
  final int? nextPage; // search

  const UnisResponse({
    required this.uniEntities,
    this.nextCursor,
    this.nextPage,
  });
}

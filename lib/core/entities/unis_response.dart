import 'package:uni/core/entities/uni_entity.dart';

class UnisResponse {
  final List<UniEntity> uniEntities;
  final String? nextCursor;

  const UnisResponse({required this.uniEntities, this.nextCursor});
}

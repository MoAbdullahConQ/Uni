import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/models/uni_model/uni_model.dart';

List<UniEntity> getUnisList(Map<String, dynamic> response) {
  List<UniEntity> Unis = <UniEntity>[];
  if (response['data'] == null) return Unis;
  for (var uni in response['data']) {
    Unis.add(UniModel.fromJson(uni));
  }
  return Unis;
}

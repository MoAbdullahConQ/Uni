import 'package:flutter/material.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_faculty_entity.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/faculty_item.dart';

class UniFacultiesTab extends StatelessWidget {
  const UniFacultiesTab({super.key, required this.uniFacultyEntities});

  final List<UniFacultyEntity> uniFacultyEntities;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: uniFacultyEntities.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) =>
          FacultyItem(uniFacultyEntity: uniFacultyEntities[i]),
    );
  }
}

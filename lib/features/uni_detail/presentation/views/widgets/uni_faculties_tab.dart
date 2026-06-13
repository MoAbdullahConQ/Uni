import 'package:flutter/material.dart';
import 'package:uni/core/widgets/empty_state_widget.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_faculty_entity.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/faculty_item.dart';

class UniFacultiesTab extends StatelessWidget {
  const UniFacultiesTab({super.key, required this.uniFacultyEntities});

  final List<UniFacultyEntity> uniFacultyEntities;

  @override
  Widget build(BuildContext context) {
    if (uniFacultyEntities.isEmpty) {
      return ListView(
        key: const PageStorageKey('faculties'),
        padding: const EdgeInsets.all(16),
        children: const [
          EmptyStateWidget(
            message: 'لا توجد كليات متاحة حالياً',
            icon: Icons.school_outlined,
          ),
        ],
      );
    }

    return ListView.separated(
      key: const PageStorageKey('faculties'),
      padding: const EdgeInsets.all(16),
      itemCount: uniFacultyEntities.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) =>
          FacultyItem(uniFacultyEntity: uniFacultyEntities[i]),
    );
  }
}
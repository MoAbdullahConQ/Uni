import 'package:flutter/material.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/widgets/uni_card.dart';
import 'package:uni/features/uni_detail/presentation/views/uni_detail_view.dart';

class UniListWidget extends StatelessWidget {
  const UniListWidget({
    super.key,
    required this.selectedFilterUniEntities,
    required this.itemCount,
    this.onDelete,
  });

  final List<UniEntity> selectedFilterUniEntities;
  final int itemCount;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return UniCard(
          selectedFilterUniEntity: selectedFilterUniEntities[index],
          // onDelete: onDelete,
          onTap: () {
            Navigator.pushNamed(context, UniDetailView.routeName);
          },
        );
      },
    );
  }
}

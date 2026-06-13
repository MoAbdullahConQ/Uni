import 'package:flutter/material.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/widgets/uni_card_with_fav.dart';
import 'package:uni/features/uni_detail/presentation/views/uni_detail_view.dart';

class UniListWidget extends StatelessWidget {
  const UniListWidget({
    super.key,
    required this.selectedFilterUniEntities,
    required this.itemCount,
    this.scrollController,
  });

  final List<UniEntity> selectedFilterUniEntities;
  final int itemCount;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      physics: scrollController != null
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      shrinkWrap: scrollController == null,
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return UniCardWithFav(
          selectedFilterUniEntity: selectedFilterUniEntities[index],
          onTap: () {
            Navigator.pushNamed(
              context,
              UniDetailView.routeName,
              arguments: selectedFilterUniEntities[index].id,
            );
          },
        );
      },
    );
  }
}

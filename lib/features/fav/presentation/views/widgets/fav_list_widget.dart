import 'package:flutter/material.dart';
import 'package:uni/features/fav/domain/entities/fav_uni_entity.dart';
import 'package:uni/features/fav/presentation/views/widgets/fav_uni_card.dart';

class FavListWidget extends StatelessWidget {
  final List<FavUniEntity> selectedFilterFavUniEntities;

  const FavListWidget({super.key, required this.selectedFilterFavUniEntities});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: selectedFilterFavUniEntities.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        return FavUniCard(
          selectedFilterFavUniEntity: selectedFilterFavUniEntities[index],
          onDelete: () {
            // TODO: trigger delete from cubit
          },
        );
      },
    );
  }
}

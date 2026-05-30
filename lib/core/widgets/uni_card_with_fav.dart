import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/widgets/uni_card.dart';
import 'package:uni/features/fav/presentation/manager/fav_cubit/fav_cubit.dart';

class UniCardWithFav extends StatelessWidget {
  const UniCardWithFav({
    super.key,
    required this.selectedFilterUniEntity,
    this.onTap,
  });

  final UniEntity selectedFilterUniEntity;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isFav = context.watch<FavCubit>().favIds.contains(
      selectedFilterUniEntity.id,
    );

    return UniCard(
      selectedFilterUniEntity: selectedFilterUniEntity,
      isFav: isFav,
      onTap: onTap,
      onFavTap: () {
        if (isFav) {
          context.read<FavCubit>().removeFromFav(selectedFilterUniEntity.id);
        } else {
          context.read<FavCubit>().addToFav(selectedFilterUniEntity.id);
        }
      },
    );
  }
}

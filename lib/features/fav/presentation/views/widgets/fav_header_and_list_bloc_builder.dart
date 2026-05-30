import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/widgets/custom_error_widget.dart';
import 'package:uni/core/widgets/uni_count_header.dart';
import 'package:uni/core/widgets/uni_list_widget.dart';
import 'package:uni/features/fav/presentation/manager/fav_cubit/fav_cubit.dart';

class FavHeaderAndListBlocBuilder extends StatelessWidget {
  const FavHeaderAndListBlocBuilder({
    super.key,
    required this.getFilteredEntitiesList,
  });

  final List<UniEntity> Function(List<UniEntity>) getFilteredEntitiesList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavCubit, FavState>(
      builder: (context, state) {
        if (state is FavFailure) {
          return CustomErrorWidget(message: state.errMessage);
        }

        List<UniEntity> currentUnis = [];
        bool isPaginationLoading = false;
        String? paginationError;

        if (state is FavSuccess) {
          currentUnis = state.uniEntities;
        } else if (state is FavPaginationLoading) {
          currentUnis = state.currentUnis;
          isPaginationLoading = true;
        } else if (state is FavPaginationFailure) {
          currentUnis = state.currentUnis;
          paginationError = state.errMessage;
        } else {
          return const Center(child: CircularProgressIndicator());
        }

        final filteredEntitiesList = getFilteredEntitiesList(currentUnis);

        return Column(
          children: [
            // Count + sort
            UniCountHeader(
              count: filteredEntitiesList.length,
              label: 'جامعات مفضلة',
            ),
            const SizedBox(height: 16),

            // List
            UniListWidget(
              selectedFilterUniEntities: filteredEntitiesList,
              itemCount: filteredEntitiesList.length,
              // onDelete: (id) => context.read<FavCubit>().removeFromFav(id),
            ),

            if (isPaginationLoading)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              ),

            if (paginationError != null)
              Padding(
                padding: const EdgeInsets.all(8),
                child: CustomErrorWidget(message: paginationError),
              ),
          ],
        );
      },
    );
  }
}

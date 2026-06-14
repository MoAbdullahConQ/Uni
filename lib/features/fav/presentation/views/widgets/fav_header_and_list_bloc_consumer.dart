import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/widgets/custom_error_widget.dart';
import 'package:uni/core/widgets/no_internet_widget.dart';
import 'package:uni/core/widgets/uni_count_header.dart';
import 'package:uni/core/widgets/uni_list_widget.dart';
import 'package:uni/features/fav/presentation/manager/fav_cubit/fav_cubit.dart';

class FavHeaderAndListBlocConsumer extends StatelessWidget {
  const FavHeaderAndListBlocConsumer({
    super.key,
    required this.getFilteredEntitiesList,
  });

  final List<UniEntity> Function(List<UniEntity>) getFilteredEntitiesList;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavCubit, FavState>(
      listenWhen: (previous, current) => current is FavActionFailure,
      listener: (context, state) {
        if (state is FavActionFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      buildWhen: (previous, current) =>
          current is FavSuccess ||
          current is FavPaginationLoading ||
          current is FavPaginationFailure ||
          current is FavFailure ||
          current is FavLoading,
      builder: (context, state) {
        if (state is FavFailure) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            child: NoInternetWidget(
              onRetry: () => context.read<FavCubit>().getFavs(),
            ),
          );
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
          return SizedBox(
            height: MediaQuery.of(context).size.height - 300,
            child: const Center(child: CircularProgressIndicator()),
          );
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

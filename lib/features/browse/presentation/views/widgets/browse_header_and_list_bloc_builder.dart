import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/widgets/custom_error_widget.dart';
import 'package:uni/core/widgets/uni_count_header.dart';
import 'package:uni/core/widgets/uni_list_widget.dart';
import 'package:uni/features/browse/presentation/manager/browse_cubit/browse_cubit.dart';
import 'package:uni/features/fav/presentation/manager/fav_cubit/fav_cubit.dart';

class BrowseHeaderAndListBlocBuilder extends StatelessWidget {
  const BrowseHeaderAndListBlocBuilder({
    super.key,
    required this.getFilteredEntitiesList,
  });

  final List<UniEntity> Function(List<UniEntity>) getFilteredEntitiesList;

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavCubit, FavState>(
      listenWhen: (previous, current) => current is FavActionFailure,
      listener: (context, state) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text((state as FavActionFailure).errMessage)),
        );
      },
      child: BlocBuilder<BrowseCubit, BrowseState>(
        builder: (context, state) {
          // States
          if (state is BrowseFailure) {
            return SizedBox(
              height:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  300,
              child: Center(
                child: CustomErrorWidget(
                  message: state.errMessage,
                  onRetry: () => context.read<BrowseCubit>().getUnis(),
                ),
              ),
            );
          }

          List<UniEntity> currentUnis = [];
          bool isPaginationLoading = false;
          String? paginationError;

          if (state is BrowseSuccess) {
            currentUnis = state.uniEntities;
          } else if (state is BrowsePaginationLoading) {
            currentUnis = state.currentUnis;
            isPaginationLoading = true;
          } else if (state is BrowsePaginationFailure) {
            currentUnis = state.currentUnis;
            paginationError = state.errMessage;
          } else {
            // BrowseInitial or BrowseLoading
            return SizedBox(
              height:
                  MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  300,
              child: const Center(child: CircularProgressIndicator()),
            );
          }
          final filteredEntitiesList = getFilteredEntitiesList(currentUnis);
          return Column(
            children: [
              // Count header
              UniCountHeader(
                count: filteredEntitiesList.length,
                label: 'جامعة مطابقة',
              ),
              const SizedBox(height: 12),

              // List
              UniListWidget(
                selectedFilterUniEntities: filteredEntitiesList,
                itemCount: filteredEntitiesList.length,
              ),

              // Pagination loading indicator
              if (isPaginationLoading)
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Center(child: CircularProgressIndicator()),
                ),

              // Pagination error
              if (paginationError != null)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: CustomErrorWidget(message: paginationError),
                ),
            ],
          );
        },
      ),
    );
  }
}

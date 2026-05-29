import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/widgets/custom_error_widget.dart';
import 'package:uni/core/widgets/uni_count_header.dart';
import 'package:uni/core/widgets/uni_list_widget.dart';
import 'package:uni/features/browse/presentation/manager/browse_cubit/browse_cubit.dart';

class HeaderAndListBlocBuilder extends StatelessWidget {
  const HeaderAndListBlocBuilder({
    super.key,
    required this.getFilteredEntitiesList,
  });

  final List<UniEntity> Function(List<UniEntity>) getFilteredEntitiesList;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrowseCubit, BrowseState>(
      builder: (context, state) {
        // States
        if (state is BrowseFailure) {
          return CustomErrorWidget(message: state.errMessage);
        } else if (state is BrowseSuccess) {
          final filteredEntitiesList = getFilteredEntitiesList(state.unis);
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
                onDelete: () {},
              ),
            ],
          );
        } else {
          return SizedBox(
            height:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                200,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

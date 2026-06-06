import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/features/search/presentation/manager/search_cubit/search_cubit.dart';
import 'package:uni/features/search/presentation/views/widgets/search_empty_widget.dart';
import 'package:uni/features/search/presentation/views/widgets/search_home_widget.dart';
import 'package:uni/features/search/presentation/views/widgets/search_results_bloc_builder.dart';

class SearchContentBlocBuilder extends StatelessWidget {
  const SearchContentBlocBuilder({
    super.key,
    required this.query,
    required this.onSearchTap,
    required this.onClearFilters,
  });

  final String query;
  final ValueChanged<String> onSearchTap;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchCubitState>(
      builder: (context, state) {
        if (state is SearchInitial) {
          return SearchHomeWidget(
            recentSearches: getDummyRecentSearches(),
            trendingSearches: getDummyTrendingSearches(),
            onClearAll: () {},
            onSearchTap: onSearchTap,
          );
        }

        if (state is SearchEmpty) {
          return SearchEmptyWidget(onClearFilters: onClearFilters);
        }

        return SearchResultsBlocBuilder(query: query);
      },
    );
  }
}

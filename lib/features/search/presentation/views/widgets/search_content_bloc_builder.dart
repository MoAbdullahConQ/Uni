import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/cubits/trending_cubit/trending_cubit.dart';
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
      builder: (context, searchState) {
        if (searchState is SearchInitial) {
          return BlocBuilder<TrendingCubit, TrendingState>(
            builder: (context, trendingState) {
              final List<String> trendingSearches =
                  trendingState is TrendingSuccess
                  ? trendingState.trendingSearches
                  : getDummyTrendingSearches();

              return SearchHomeWidget(
                recentSearches: getDummyRecentSearches(),
                trendingSearches: trendingSearches,
                onClearAll: () {},
                onSearchTap: onSearchTap,
              );
            },
          );
        }

        if (searchState is SearchEmpty) {
          return SearchEmptyWidget(onClearFilters: onClearFilters);
        }

        return SearchResultsBlocBuilder(query: query);
      },
    );
  }
}

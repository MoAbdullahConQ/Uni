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
    required this.recentSearches,
    required this.onSearchTap,
    required this.onDeleteRecent,
    required this.onClearAllRecent,
    required this.onClearFilters,
  });

  final String query;
  final List<String> recentSearches;
  final ValueChanged<String> onSearchTap;
  final ValueChanged<String> onDeleteRecent;
  final VoidCallback onClearAllRecent;
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
                recentSearches: recentSearches, // real recent searches from shared prefs
                trendingSearches: trendingSearches,
                onClearAll: onClearAllRecent, // remove all recent searches
                onDeleteRecent: onDeleteRecent, // remove one recent search
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

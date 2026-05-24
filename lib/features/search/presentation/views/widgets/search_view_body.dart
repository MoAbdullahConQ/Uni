import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/core/widgets/filter_button_badge.dart';
import 'package:uni/core/widgets/search_bar_field.dart';
import 'package:uni/features/search/domain/entities/search_filter_entity.dart';
import 'package:uni/features/search/presentation/views/widgets/search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/search_home_widget.dart';
import 'package:uni/features/search/presentation/views/widgets/search_results_widget.dart';

enum SearchState { home, results, empty }

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final TextEditingController controller = TextEditingController();
  SearchFilterEntity searchFilterEntity = const SearchFilterEntity();
  SearchState searchState = SearchState.home;
  List<UniEntity> results = [];

  void onSearchChanged(String query) {
    if (query.isEmpty) {
      setState(() => searchState = SearchState.home);
      return;
    }

    // TODO: replace with cubit search call
    final allResults = getDummySearchResults();
    final filtered = allResults
        .where((e) => e.name.contains(query) || e.type.contains(query))
        .toList();

    setState(() {
      results = filtered;
      searchState = filtered.isEmpty ? SearchState.empty : SearchState.results;
    });
  }

  void showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SearchFilterBottomSheet(
          initialSearchFilterEntity: searchFilterEntity,
          onApply: (searchFilterEntity) {
            setState(() {
              this.searchFilterEntity = searchFilterEntity;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: Column(
        children: [
          // App bar
          SearchBarField(
            controller: controller,
            hintText: 'ابحث عن جامعة، كلية، أو تخصص',
            showBackButton: true,
            onChanged: onSearchChanged,
            onClear: () {
              controller.clear();
              setState(() {
                searchState = SearchState.home;
              });
            },
            trailing: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: FilterButtonBadge(
                activeFiltersCount: searchFilterEntity.activeFiltersCount,
                onFilterTap: showFilterSheet,
              ),
            ),
          ),

          // Content
          Expanded(
            child: switch (searchState) {
              SearchState.home => SearchHomeWidget(
                recentSearches: getDummyRecentSearches(),
                trendingSearches: getDummyTrendingSearches(),
                onClearAll: () {},
              ),
              SearchState.results => SearchResultsWidget(
                results: results,
                query: controller.text,
              ),
              SearchState.empty => Text('empty'),
            },
          ),
        ],
      ),
    );
  }
}

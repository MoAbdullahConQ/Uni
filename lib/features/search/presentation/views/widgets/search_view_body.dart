import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/widgets/filter_button_badge.dart';
import 'package:uni/core/widgets/search_bar_field.dart';
import 'package:uni/features/search/domain/entities/search_filter_entity.dart';
import 'package:uni/features/search/domain/use_cases/get_specialties_use_case.dart';
import 'package:uni/features/search/presentation/manager/search_cubit/search_cubit.dart';
import 'package:uni/features/search/presentation/manager/specialties_cubit/specialties_cubit.dart';
import 'package:uni/features/search/presentation/views/widgets/search_empty_widget.dart';
import 'package:uni/features/search/presentation/views/widgets/search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/search_home_widget.dart';
import 'package:uni/features/search/presentation/views/widgets/search_results_bloc_builder.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final TextEditingController controller = TextEditingController();
  SearchFilterEntity searchFilterEntity = const SearchFilterEntity();

  void _onSearchChanged(String query) {
    context.read<SearchCubit>().search(
      query: query,
      filter: searchFilterEntity,
    );
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider(
        create: (context) => SpecialtiesCubit(getIt<GetSpecialtiesUseCase>()),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SearchFilterBottomSheet(
            initialSearchFilterEntity: searchFilterEntity,
            onApply: (newFilter) {
              setState(() => searchFilterEntity = newFilter);
              context.read<SearchCubit>().search(
                query: controller.text,
                filter: newFilter,
              );
            },
          ),
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
          // Search bar
          SearchBarField(
            controller: controller,
            hintText: 'ابحث عن جامعة، كلية، أو تخصص',
            showBackButton: true,
            onChanged: _onSearchChanged,
            onClear: () {
              controller.clear();
              context.read<SearchCubit>().search(
                query: '',
                filter: searchFilterEntity,
              );
            },
            trailing: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: FilterButtonBadge(
                activeFiltersCount: searchFilterEntity.activeFiltersCount,
                onFilterTap: _showFilterSheet,
              ),
            ),
          ),

          // Content
          Expanded(
            child: BlocBuilder<SearchCubit, SearchCubitState>(
              builder: (context, state) {
                if (state is SearchInitial) {
                  return SearchHomeWidget(
                    recentSearches: getDummyRecentSearches(),
                    trendingSearches: getDummyTrendingSearches(),
                    onClearAll: () {},
                    onSearchTap: (query) {
                      controller.text = query;
                      _onSearchChanged(query);
                    },
                  );
                }

                if (state is SearchEmpty) {
                  return SearchEmptyWidget(
                    onClearFilters: () {
                      setState(
                        () => searchFilterEntity = const SearchFilterEntity(),
                      );
                      controller.clear();
                      context.read<SearchCubit>().search(
                        query: '',
                        filter: const SearchFilterEntity(),
                      );
                    },
                  );
                }
                return SearchResultsBlocBuilder(query: controller.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}

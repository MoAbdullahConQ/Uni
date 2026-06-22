import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/helper_functions/recent_searches_helper.dart';
import 'package:uni/core/widgets/filter_button_badge.dart';
import 'package:uni/core/widgets/search_bar_field.dart';
import 'package:uni/features/search/domain/entities/search_filter_entity.dart';
import 'package:uni/features/search/domain/use_cases/get_specialties_use_case.dart';
import 'package:uni/features/search/presentation/manager/search_cubit/search_cubit.dart';
import 'package:uni/features/search/presentation/manager/specialties_cubit/specialties_cubit.dart';
import 'package:uni/features/search/presentation/views/widgets/search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/search_content_bloc_builder.dart';
import 'package:uni/core/services/get_it_service.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final TextEditingController controller = TextEditingController();
  SearchFilterEntity searchFilterEntity = const SearchFilterEntity();
  List<String> recentSearches = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    //get recent searches when page opens
    recentSearches = RecentSearchesHelper.getAll();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<SearchCubit>().search(
        query: query,
        filter: searchFilterEntity,
      );
    });
  }

  /// called when user submits search (from keyboard or recent item tap)
  Future<void> _onSearchSubmitted(String query) async {
    if (query.trim().isEmpty) return;
    await RecentSearchesHelper.add(query);
    setState(() => recentSearches = RecentSearchesHelper.getAll());
    _onSearchChanged(query);
  }

  Future<void> _onDeleteRecent(String query) async {
    await RecentSearchesHelper.remove(query);
    setState(() => recentSearches = RecentSearchesHelper.getAll());
  }

  Future<void> _onClearAllRecent() async {
    await RecentSearchesHelper.clearAll();
    setState(() => recentSearches = []);
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
    _debounce?.cancel();
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
            height: 50,
            controller: controller,
            hintText: 'ابحث عن جامعة، كلية، أو تخصص',
            showBackButton: true,
            onChanged: _onSearchChanged,
            onSubmitted: _onSearchSubmitted, // save when submit
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
            child: SearchContentBlocBuilder(
              query: controller.text,
              recentSearches: recentSearches,
              onSearchTap: (query) {
                controller.text = query;
                _onSearchSubmitted(query);
              },
              onDeleteRecent: _onDeleteRecent,
              onClearAllRecent: _onClearAllRecent,
              onClearFilters: () {
                setState(() => searchFilterEntity = const SearchFilterEntity());
                controller.clear();
                context.read<SearchCubit>().search(
                  query: '',
                  filter: const SearchFilterEntity(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/widgets/filter_button_badge.dart';
import 'package:uni/core/widgets/search_bar_field.dart';
import 'package:uni/core/widgets/uni_filter_tab_bar.dart';
import 'package:uni/features/browse/presentation/views/widgets/header_and_list_bloc_builder.dart';
import 'package:uni/features/search/presentation/views/search_view.dart';

class BrowseViewBody extends StatefulWidget {
  const BrowseViewBody({super.key});

  @override
  State<BrowseViewBody> createState() => _BrowseViewBodyState();
}

class _BrowseViewBodyState extends State<BrowseViewBody> {
  String selectedFilter = 'الكل';

  List<UniEntity> getFilteredEntitiesList(List<UniEntity> unis) {
    if (selectedFilter == 'الكل') return unis;
    return unis.where((e) => e.type == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kTopPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App bar
            SearchBarField(
              hintText: 'اكتب اسم الجامعه',
              showBackButton: true,
              height: 50,
              onTap: () {
                Navigator.pushNamed(context, SearchView.routeName);
              },
              trailing: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: FilterButtonBadge(
                  activeFiltersCount: 3,
                  onFilterTap: () {},
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Filter tab bar
            UniFilterTabBar(
              selectedFilter: selectedFilter,
              onFilterChanged: (filter) {
                setState(() => selectedFilter = filter);
              },
            ),
            const SizedBox(height: 16),

            HeaderAndListBlocBuilder(
              getFilteredEntitiesList: getFilteredEntitiesList,
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

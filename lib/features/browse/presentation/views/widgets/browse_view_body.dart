import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/core/widgets/filter_button_badge.dart';
import 'package:uni/core/widgets/search_bar_field.dart';
import 'package:uni/core/widgets/uni_count_header.dart';
import 'package:uni/core/widgets/uni_filter_tab_bar.dart';
import 'package:uni/core/widgets/uni_list_widget.dart';

class BrowseViewBody extends StatefulWidget {
  const BrowseViewBody({super.key});

  @override
  State<BrowseViewBody> createState() => _BrowseViewBodyState();
}

class _BrowseViewBodyState extends State<BrowseViewBody> {
  String selectedFilter = 'الكل';

  // TODO: replace with cubit
  final List<UniEntity> allBrowseUniEntities = getDummyUniEntities();

  List<UniEntity> get filteredEntities {
    if (selectedFilter == 'الكل') return allBrowseUniEntities;
    return allBrowseUniEntities.where((e) => e.type == selectedFilter).toList();
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

            // Count header
            const UniCountHeader(count: 0, label: 'جامعة مطابقة'),
            const SizedBox(height: 12),

            // List
            UniListWidget(
              selectedFilterUniEntities: filteredEntities,
              itemCount: filteredEntities.length,
              onDelete: () {},
              onTap: () {},
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

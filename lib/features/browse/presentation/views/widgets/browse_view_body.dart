import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/widgets/filter_button_badge.dart';
import 'package:uni/core/widgets/search_bar_field.dart';
import 'package:uni/core/widgets/uni_filter_tab_bar.dart';

class BrowseViewBody extends StatefulWidget {
  const BrowseViewBody({super.key});

  @override
  State<BrowseViewBody> createState() => _BrowseViewBodyState();
}

class _BrowseViewBodyState extends State<BrowseViewBody> {
  String selectedFilter = 'الكل';

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
          ],
        ),
      ),
    );
  }
}

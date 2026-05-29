import 'package:flutter/material.dart';
import 'package:uni/core/widgets/filter_tab_bar_item.dart';

class UniFilterTabBar extends StatelessWidget {
  const UniFilterTabBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  final ValueChanged<String> onFilterChanged;
  final String selectedFilter;

  static const List<String> filters = ['الكل', 'حكومية', 'خاصة'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return FilterTabBarItem(
            onFilterChanged: onFilterChanged,
            filter: filters[index],
            isSelected: filters[index] == selectedFilter,
          );
        },
      ),
    );
  }
}

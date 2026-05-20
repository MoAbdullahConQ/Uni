import 'package:flutter/material.dart';
import 'package:uni/features/fav/presentation/views/widgets/fav_filter_tab_bar_item.dart';

class UniFilterTabBar extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const UniFilterTabBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  static const List<String> filters = ['الكل', 'حكومية', 'خاصة', 'معهد عالي'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return FavFilterTabBarItem(
            onFilterChanged: onFilterChanged,
            filter: filters[index],
            isSelected: filters[index] == selectedFilter,
          );
        },
      ),
    );
  }
}

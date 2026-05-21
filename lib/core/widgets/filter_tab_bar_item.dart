import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class FilterTabBarItem extends StatelessWidget {
  const FilterTabBarItem({
    super.key,
    required this.onFilterChanged,
    required this.filter,
    required this.isSelected,
  });

  final ValueChanged<String> onFilterChanged;
  final String filter;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onFilterChanged(filter);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.secondaryColor : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? AppColors.secondaryColor
                : AppColors.borderColor,
            width: 1.2,
          ),
        ),
        child: Text(
          filter,
          style: TextStyles.bold14.copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

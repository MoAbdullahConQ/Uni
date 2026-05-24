import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/search/presentation/views/widgets/filter_type_checkbox.dart';

class UniTypesSearchFilterBottomSheet extends StatelessWidget {
  const UniTypesSearchFilterBottomSheet({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.types,
  });

  final List<String> types;
  final bool Function(String) isSelected;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'نوع الجامعة',
          style: TextStyles.bold18.copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 12),
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 3.2,
          children: types
              .map(
                (t) => FilterTypeCheckbox(
                  label: t,
                  isSelected: isSelected(t),
                  onTap: () {
                    onTap(t);
                  },
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

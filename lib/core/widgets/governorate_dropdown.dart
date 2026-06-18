import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class GovernorateDropdown extends StatelessWidget {
  const GovernorateDropdown({
    super.key,
    required this.selectedId,
    required this.onChanged,
  });

  final int? selectedId;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.borderColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          menuMaxHeight: 600,
          value: selectedId,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 20),
          hint: Text(
            'اختر محافظتك',
            style: TextStyles.regular16.copyWith(
              color: AppColors.primaryColor.withOpacity(.4),
            ),
          ),
          items: kGovernorates
              .map(
                (g) => DropdownMenuItem<int>(
                  value: g['id'] as int,
                  child: Text(g['name'] as String),
                ),
              )
              .toList(),
          onChanged: onChanged,
          style: TextStyles.regular16.copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/search/presentation/views/widgets/filter_specialty_chip.dart';

class SpecialtiesSearchFilterBottomSheet extends StatelessWidget {
  const SpecialtiesSearchFilterBottomSheet({
    super.key,
    required this.specialties,
    required this.isSelected,
    required this.onTap,
  });

  final List<String> specialties;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'التخصص',
          style: TextStyles.bold18.copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: specialties
              .map(
                (s) => FilterSpecialtyChip(
                  label: s,
                  isSelected: isSelected,
                  onTap: onTap,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

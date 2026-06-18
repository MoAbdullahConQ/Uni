import 'package:flutter/material.dart';
import 'package:uni/core/widgets/age_field.dart';
import 'package:uni/core/widgets/field_label.dart';
import 'package:uni/core/widgets/governorate_dropdown.dart';
import 'package:uni/core/widgets/percentage_field.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({
    super.key,
    required this.selectedGovernorateId,
    required this.onGovernorateChanged,
    required this.percentageController,
    required this.ageController,
  });

  final int? selectedGovernorateId;
  final ValueChanged<int?> onGovernorateChanged;
  final TextEditingController percentageController;
  final TextEditingController ageController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const FieldLabel(label: 'المحافظة'),
              const SizedBox(height: 8),
              GovernorateDropdown(
                selectedId: selectedGovernorateId,
                onChanged: onGovernorateChanged,
              ),
            ],
          ),
        ),
        const SizedBox(width: 28),
        Expanded(
          child: Column(
            children: [
              const FieldLabel(label: 'النسبة المئوية'),
              const SizedBox(height: 8),
              PercentageField(controller: percentageController),
            ],
          ),
        ),
        const SizedBox(width: 28),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const FieldLabel(label: 'عمرك'),
              const SizedBox(height: 8),
              AgeField(controller: ageController),
            ],
          ),
        ),
      ],
    );
  }
}

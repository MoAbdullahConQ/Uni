import 'package:flutter/material.dart';
import 'package:uni/core/widgets/custom_text_form_field.dart';
import 'package:uni/features/profile/presentation/views/widgets/governorate_dropdown.dart';
import 'package:uni/features/profile/presentation/views/widgets/percentage_field.dart';
import 'package:uni/features/profile/presentation/views/widgets/personal_data_field_label.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Column(
            children: [
              PersonalDataFieldLabel(label: 'المحافظة'),
              SizedBox(height: 8),
              GovernorateDropdown(),
            ],
          ),
        ),
        SizedBox(width: 28),
        Expanded(
          child: Column(
            children: [
              PersonalDataFieldLabel(label: 'النسبة المئوية'),
              SizedBox(height: 8),
              PercentageField(),
            ],
          ),
        ),
        SizedBox(width: 28),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              PersonalDataFieldLabel(label: 'عمرك'),
              SizedBox(height: 8),
              CustomTextFormField(
                hintText: '23 سنة',
                keyboardType: TextInputType.number,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

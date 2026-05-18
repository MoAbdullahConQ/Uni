import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class PersonalDataFieldLabel extends StatelessWidget {
  final String label;

  const PersonalDataFieldLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        label,
        style: TextStyles.semiBold14.copyWith(color: AppColors.primaryColor),
      ),
    );
  }
}

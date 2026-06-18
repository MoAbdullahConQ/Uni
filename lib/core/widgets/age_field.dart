import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class AgeField extends StatelessWidget {
  const AgeField({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E9E9)),
      ),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.right,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          hintText: '18',
          hintStyle: TextStyles.regular16.copyWith(
            color: AppColors.primaryColor.withOpacity(.4),
          ),
        ),
        style: TextStyles.regular16.copyWith(color: AppColors.primaryColor),
        validator: (value) {
          if (value == null || value.isEmpty) return '';
          final age = int.tryParse(value);
          if (age == null || age < 14 || age > 30) return '';
          return null;
        },
      ),
    );
  }
}

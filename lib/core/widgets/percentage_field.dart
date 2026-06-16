import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class PercentageField extends StatelessWidget {
  const PercentageField({super.key, this.controller});

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E9E9)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              textAlign: TextAlign.right,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d{0,3}\.?\d*')),
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: '90.5',
                hintStyle: TextStyles.regular16.copyWith(
                  color: AppColors.primaryColor.withOpacity(.4),
                ),
              ),
              style: TextStyles.regular16.copyWith(
                color: AppColors.primaryColor,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return '';
                final v = double.tryParse(value);
                if (v == null || v < 0 || v > 100) return '';
                return null;
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '%',
              style: TextStyles.regular16.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class GovernorateDropdown extends StatelessWidget {
  const GovernorateDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E9E9)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: 'القاهرة',
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 20),
          items: const [
            DropdownMenuItem(value: 'القاهرة', child: Text('القاهرة')),
            DropdownMenuItem(value: 'الجيزة', child: Text('الجيزة')),
            DropdownMenuItem(value: 'الإسكندرية', child: Text('الإسكندرية')),
          ],
          onChanged: (_) {},
          style: TextStyles.regular16.copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

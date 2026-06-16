import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key, this.value, this.onChanged});

  final bool? value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          activeColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        Text(
          'أوافق على',
          style: TextStyles.regular14.copyWith(color: AppColors.subtitleColor),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () {},
          child: Text(
            'الشروط والأحكام',
            style: TextStyles.regular14.copyWith(
              color: AppColors.primaryColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

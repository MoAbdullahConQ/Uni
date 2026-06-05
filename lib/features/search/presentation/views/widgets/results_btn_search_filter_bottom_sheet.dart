import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';

class ResultsBtnSearchFilterBottomSheet extends StatelessWidget {
  const ResultsBtnSearchFilterBottomSheet({super.key, required this.onPressed});

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            onPressed: onPressed,
            text: 'تطبيق الفلتر',
            backgroundColor: AppColors.secondaryColor,
            style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}

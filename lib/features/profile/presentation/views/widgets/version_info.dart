import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class VersionInfo extends StatelessWidget {
  const VersionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'تطبيق جامعتي',
          style: TextStyles.semiBold13.copyWith(
            color: AppColors.subtitleColor.withOpacity(.8),
          ),
        ),
        Text(
          'V.1.0.0',
          style: TextStyles.semiBold13.copyWith(
            color: AppColors.subtitleColor.withOpacity(.8),
          ),
        ),
      ],
    );
  }
}

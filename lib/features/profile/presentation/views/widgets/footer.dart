import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '© جامعتي 2024. جميع الحقوق محفوظة.',
          style: TextStyles.semiBold13.copyWith(color: AppColors.subtitleColor),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Text(
                'الشروط والأحكام',
                style: TextStyles.semiBold11.copyWith(
                  color: AppColors.subtitleColor,
                ),
              ),
            ),
            Text(
              '  |  ',
              style: TextStyles.semiBold11.copyWith(
                color: AppColors.subtitleColor,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'سياسة الخصوصية',
                style: TextStyles.semiBold11.copyWith(
                  color: AppColors.subtitleColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

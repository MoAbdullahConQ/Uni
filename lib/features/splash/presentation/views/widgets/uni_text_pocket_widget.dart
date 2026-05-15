import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class UniTextPocketWidget extends StatelessWidget {
  const UniTextPocketWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'كل جامعات مصر ',
            style: TextStyles.bold32.copyWith(color: AppColors.primaryColor),
          ),
          TextSpan(
            text: 'في جيبك',
            style: TextStyles.bold32.copyWith(
              color: AppColors.lightPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

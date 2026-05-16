import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/search_text_field.dart';
import 'package:uni/features/home/presentation/views/widgets/custom_home_app_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kTopPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHomeAppBar(),
            SizedBox(height: 24),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'دور علي ',
                    style: TextStyles.bold32.copyWith(
                      color: AppColors.primaryColor,
                      height: 1.25,
                    ),
                  ),
                  TextSpan(
                    text: 'مستقبلك',
                    style: TextStyles.bold32.copyWith(
                      color: AppColors.lightPrimaryColor,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'هتلاقي كل الجامعات المصريه بسهوله',
              style: TextStyles.regular14.copyWith(
                color: Color(0xFF99A1AE),
                height: 1.43,
              ),
            ),
            SizedBox(height: 16),
            SearchTextField(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

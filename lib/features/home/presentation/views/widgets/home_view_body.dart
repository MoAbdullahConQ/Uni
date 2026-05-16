import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/search_text_field.dart';
import 'package:uni/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:uni/features/home/presentation/views/widgets/faheem_banner_widget.dart';
import 'package:uni/features/home/presentation/views/widgets/recommended_unis_section.dart';
import 'package:uni/features/home/presentation/views/widgets/trending_unis_section.dart';
import 'package:uni/features/home/presentation/views/widgets/uni_tile.dart';

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
            const SizedBox(height: 24),
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
            const SizedBox(height: 16),
            Text(
              'هتلاقي كل الجامعات المصريه بسهوله',
              style: TextStyles.regular14.copyWith(
                color: AppColors.subtitleColor.withOpacity(0.8),
                height: 1.43,
              ),
            ),
            const SizedBox(height: 16),
            const SearchTextField(),
            const SizedBox(height: 16),
            const FaheemBannerWidget(),
            const SizedBox(height: 16),
            const UniversityTile(),
            const SizedBox(height: 32),
            const TrendingUnisSection(),
            const SizedBox(height: 32),
            const RecommendedUnisSection(),
            const SizedBox(height: 32),

          ],
        ),
      ),
    );
  }
}

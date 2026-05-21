import 'package:flutter/material.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/faheem/presentation/views/widgets/suggestion_chip.dart';
import 'package:uni/features/profile/presentation/views/widgets/robot_section.dart';

class FaheemWelcomeWidget extends StatelessWidget {
  const FaheemWelcomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),

        // Robot image + Welcome text
        RobotSection(
          title: '👋 أهلاً بيك يا بطل!',
          titleStyle: TextStyles.bold24.copyWith(color: AppColors.primaryColor),
          subTitle: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'أنا ',
                  style: TextStyles.regular16.copyWith(
                    color: AppColors.subtitleColor,
                  ),
                ),
                TextSpan(
                  text: 'فهيم افندي',
                  style: TextStyles.bold16.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                TextSpan(
                  text: '، دليلك الذي عشان نختار سوا كليتك المناسبة لمستقبلك.',
                  style: TextStyles.regular16.copyWith(
                    color: AppColors.subtitleColor,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          heightImage: 220,
        ),

        const SizedBox(height: 20),

        // Suggestions grid
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.6,
          children: getDummySuggestionItems()
              .map((s) => SuggestionChip(suggestionItemEntity: s))
              .toList(),
        ),
      ],
    );
  }
}

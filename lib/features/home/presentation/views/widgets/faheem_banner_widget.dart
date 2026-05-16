import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/home/presentation/views/widgets/glowing_action_button.dart';
import 'package:uni/features/home/presentation/views/widgets/top_tag.dart';

class FaheemBannerWidget extends StatelessWidget {
  const FaheemBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightPrimaryColor.withOpacity(0.4),
            blurRadius: 25,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Right side: Text and Button
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Tag
                const TopTag(),
                const SizedBox(height: 5),

                // Headline
                Text(
                  'محتار تختار كليتك؟',
                  style: TextStyles.bold24.copyWith(
                    color: AppColors.secondaryColor,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 5),

                // Subtitle
                Text(
                  'فهيم هيقارن بين الجامعات ويقترحلك الأفضل لمجموعك.',
                  style: TextStyles.regular14.copyWith(
                    height: 1.43,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),

                // Glowing Action Button
                const GlowingActionButton(),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Left side: Illustration
          SvgPicture.asset(
            Assets.imagesFaheemRobot,
            height: 130,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';

class RobotSection extends StatelessWidget {
  const RobotSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 200,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withOpacity(.01),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 70,
                  offset: const Offset(0, 20),
                  spreadRadius: 20,
                  color: AppColors.secondaryColor.withOpacity(.5),
                ),
              ],
            ),
            child: SvgPicture.asset(Assets.imagesRobot, height: 150),
          ),
          const SizedBox(height: 12),
          Text(
            'كيف يمكننا مساعدتك؟',
            style: TextStyles.bold24.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 6),
          Text(
            'فريقنا متواجد دائماً للرد على استفساراتك ومساعدتك في رحلتك الجامعية تواصل معنا عبر القنوات المتاحة.',
            textAlign: TextAlign.center,
            style: TextStyles.regular14.copyWith(
              color: AppColors.subtitleColor,
            ),
          ),
        ],
      ),
    );
  }
}

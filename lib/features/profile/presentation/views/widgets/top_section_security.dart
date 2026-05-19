import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';

class TopSectionSecurity extends StatelessWidget {
  const TopSectionSecurity({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: AppColors.primaryColor.withOpacity(.2),
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(.1),
                  blurRadius: 15,
                  offset: const Offset(0, 10),
                  spreadRadius: -3,
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(Assets.imagesVerified, height: 40),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'قم بتحديث كلمة المرور الخاصة بك بشكل دوري\nللحفاظ على أمان حسابك.',
          textAlign: TextAlign.center,
          style: TextStyles.regular14.copyWith(
            color: AppColors.primaryColor.withOpacity(.6),
          ),
        ),
      ],
    );
  }
}

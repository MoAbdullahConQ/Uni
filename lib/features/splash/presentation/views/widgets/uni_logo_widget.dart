import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_fonts.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';

class UniLogoWidget extends StatelessWidget {
  const UniLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 183,
      padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 36),
      decoration: ShapeDecoration(
        color: AppColors.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
        shadows: [
          BoxShadow(
            color: AppColors.secondaryColor,
            blurRadius: 100,
            offset: Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          SvgPicture.asset(Assets.imagesLogo),
          Text(
            'جامعتي',
            textAlign: TextAlign.center,
            style: TextStyles.regular40.copyWith(
              color: AppColors.lightSecondaryColor,
              fontFamily: AppFonts.palestineFont,
            ),
          ),
        ],
      ),
    );
  }
}

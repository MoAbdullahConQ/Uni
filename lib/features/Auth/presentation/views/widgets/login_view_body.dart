import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_fonts.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/auth/presentation/views/widgets/auth_header.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 90),
            // header: logo + title + subtitle
            AuthHeader(
              borderRadius: 22,
              title: 'أهلاً برجوعك 👋',
              subtitle: 'سجل الدخول وابداء رحلتك الجامعية',
              showLogo: true,
              verticalPaddingContainer: 8,
              horizontalPaddingContainer: 16,
              // icon: Icon(Icons.logo_dev),
              colorContainer: AppColors.primaryColor,
              childContainer: Column(
                children: [
                  SvgPicture.asset(Assets.imagesLogo, height: 36),
                  Text(
                    'جامعتي',
                    textAlign: TextAlign.center,
                    style: TextStyles.regular16.copyWith(
                      color: AppColors.lightSecondaryColor,
                      fontFamily: AppFonts.palestineFont,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

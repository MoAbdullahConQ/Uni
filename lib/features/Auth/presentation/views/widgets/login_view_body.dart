import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_fonts.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:uni/features/auth/presentation/views/widgets/login_form.dart';
import 'package:uni/features/auth/presentation/views/widgets/no_Account_row.dart';
import 'package:uni/features/auth/presentation/views/widgets/or_divider.dart';

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
            const SizedBox(height: 50),
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

            const SizedBox(height: 32),

            // login form
            const LoginForm(),
            const SizedBox(height: 24),

            // divider
            const OrDivider(),
            const SizedBox(height: 16),

            // social buttons
            CustomButton(
              onPressed: () {},
              text: 'Google',
              borderColor: AppColors.borderColor,
              style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: SvgPicture.asset(Assets.imagesGoogle, height: 20),
              ),
            ),
            const SizedBox(height: 24),

            // no account row
            const NoAccountRow(),
            const SizedBox(height: 26),
          ],
        ),
      ),
    );
  }
}

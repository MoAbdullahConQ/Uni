import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/widgets/back_button.dart';
import 'package:uni/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:uni/features/auth/presentation/views/widgets/verified_badge.dart';

class ResetPasswordViewBody extends StatelessWidget {
  const ResetPasswordViewBody({super.key, required this.tempToken});

  final String tempToken;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // top row: back button + verified badge
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomBackButton(),
                Spacer(flex: 2),
                VerifiedBadge(),
                Spacer(flex: 3),
              ],
            ),
            const SizedBox(height: 40),

            AuthHeader(
              title: 'كلمة المرور الجديدة🔒',
              subtitle: 'قم بإنشاء كلمة مرور قوية لتأمين حسابك',
              showLogo: true,
              borderRadius: 30,
              colorContainer: Colors.white,
              horizontalPaddingContainer: 26,
              verticalPaddingContainer: 26,
              childContainer: SvgPicture.asset(
                Assets.imagesVerified,
                height: 40,
              ),
            ),
            const SizedBox(height: 24),

            
          ],
        ),
      ),
    );
  }
}

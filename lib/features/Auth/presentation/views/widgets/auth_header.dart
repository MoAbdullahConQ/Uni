import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.showLogo = false,
    // this.icon,
    this.verticalPaddingContainer,
    this.horizontalPaddingContainer,
    this.colorContainer,
    this.childContainer,
    this.borderRadius,
  });

  final String title;
  final String subtitle;
  final bool showLogo;

  // optional icon widget shown above title (used in forgot password, reset password screens)
  // final Widget? icon;

  final double? verticalPaddingContainer,
      horizontalPaddingContainer,
      borderRadius;

  final Color? colorContainer;

  final Widget? childContainer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showLogo) ...[
          Container(
            margin: const EdgeInsets.only(left: 24),
            transform: Matrix4.identity()
              ..translate(0.0, 0.0)
              ..rotateZ(0.16),
            padding: EdgeInsets.symmetric(
              vertical: verticalPaddingContainer ?? 0,
              horizontal: horizontalPaddingContainer ?? 0,
            ),
            decoration: ShapeDecoration(
              color: colorContainer,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: AppColors.borderColor, width: 1.4),
                borderRadius: BorderRadius.circular(borderRadius ?? 16),
              ),
              shadows: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(.1),
                  blurRadius: 15,
                  offset: const Offset(0, 10),
                  spreadRadius: -3,
                ),
              ],
            ),
            child: childContainer,
          ),
          // SvgPicture.asset(Assets.imagesLogo, height: 72),
        ],
        // if (icon != null) ...[icon!, const SizedBox(height: 16)],
        const SizedBox(height: 30),
        Text(
          title,
          style: TextStyles.bold28.copyWith(color: AppColors.primaryColor),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyles.regular16.copyWith(
            color: AppColors.primaryColor.withOpacity(0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

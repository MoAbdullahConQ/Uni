import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';

class SearchBarField extends StatelessWidget {
  const SearchBarField({
    super.key,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.iconColor,
    this.suffixIcon,
    this.leading,
    this.trailing,
    this.showBackButton = false,
    this.onBackPressed,
    this.height = 48,
    this.hintStyle,
    this.borderRadius = 16,
    this.borderWidth = 1.4,
    this.borderColor,
    this.fillColor = Colors.white,
    this.shadow,
    this.onTap,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final Color? iconColor;
  final Widget? suffixIcon;
  final Widget? leading;
  final Widget? trailing;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final void Function()? onTap;

  // ── Style ──
  final double height;
  final TextStyle? hintStyle;
  final double borderRadius;
  final double borderWidth;
  final Color? borderColor;
  final Color fillColor;
  final BoxShadow? shadow;

  @override
  Widget build(BuildContext context) {
    final field = Container(
      height: height,
      decoration: ShapeDecoration(
        color: fillColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: borderWidth,
            color: borderColor ?? AppColors.primaryColor.withOpacity(0.15),
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        shadows: [
          shadow ??
              const BoxShadow(
                color: AppColors.shadowBlack,
                blurRadius: 3,
                offset: Offset(0, 1),
              ),
        ],
      ),
      child: TextField(
        readOnly: onTap != null,
        onTap: onTap,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: SizedBox(
            width: 20,
            child: Center(
              child: SvgPicture.asset(
                Assets.imagesIconSearch,
                color: iconColor,
              ),
            ),
          ),
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle:
              hintStyle ??
              TextStyles.regular14.copyWith(
                color: AppColors.subtitleColor.withOpacity(0.55),
              ),
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: _buildBorder(),
          filled: true,
          fillColor: fillColor,
        ),
      ),
    );

    if (leading == null && !showBackButton && trailing == null) {
      return field;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (leading != null)
          leading!
        else if (showBackButton)
          IconButton(
            onPressed: onBackPressed ?? () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          ),
        Expanded(child: field),
        if (trailing != null) trailing!,
      ],
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: const BorderSide(color: Colors.white),
    );
  }
}

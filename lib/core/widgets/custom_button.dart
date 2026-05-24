import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.style,
    this.borderColor,
    this.prefixIcon,
  });

  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor, borderColor;
  final TextStyle? style;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: borderColor ?? AppColors.borderColor,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(16),
          ),

          backgroundColor: backgroundColor,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) prefixIcon!,
            Text(text, style: style),
          ],
        ),
      ),
    );
  }
}

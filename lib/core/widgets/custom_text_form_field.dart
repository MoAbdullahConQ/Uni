import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    this.suffixIcon,
    this.onSaved,
    this.obscureText = false, this.prefixIcon, required this.textAlign,
  });

  final Widget? suffixIcon;

  final bool obscureText;

  final String hintText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final void Function(String?)? onSaved;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      onSaved: onSaved,
      textAlign: textAlign,
      validator: (value) {
        if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
        return null;
      },
      keyboardType: keyboardType,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyles.regular16.copyWith(
          color: AppColors.primaryColor.withOpacity(.6),
        ),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                size: 24,
                color: AppColors.primaryColor.withOpacity(.5),
              )
            : null,
        filled: true,
        fillColor: const Color(0xFFF9FAFA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: buildBorder(),
        enabledBorder: buildBorder(),
        focusedBorder: buildFocusedBorder(),
        errorBorder: buildBorder(),
        focusedErrorBorder: buildFocusedBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: const Color(0xFFE6E9E9), width: 1),
      borderRadius: BorderRadius.circular(12),
    );
  }

  OutlineInputBorder buildFocusedBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF6BBF26), width: 1.5),
      borderRadius: BorderRadius.circular(12),
    );
  }
}

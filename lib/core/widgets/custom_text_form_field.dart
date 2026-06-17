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
    this.obscureText = false,
    this.prefixIcon,
    required this.textAlign,
    this.controller,
    this.onChanged,
    this.validator,
    this.borderColor,
  });

  final Widget? suffixIcon;

  final bool obscureText;

  final String hintText;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final void Function(String?)? onSaved;
  final TextAlign textAlign;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,
      onSaved: onSaved,
      onChanged: onChanged,
      textAlign: textAlign,
      validator:
          validator ??
          (value) {
            if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
            return null;
          },
      keyboardType: keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyles.regular16.copyWith(
          color: AppColors.primaryColor.withOpacity(.6),
        ),
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: const Color(0xFFF9FAFA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: buildBorder(borderColor),
        enabledBorder: buildBorder(borderColor),
        focusedBorder: buildFocusedBorder(
          borderColor ?? AppColors.primaryColor.withOpacity(.1),
        ),
        isDense: true,
        // errorStyle: const TextStyle(fontSize: 0, height: 0),
        errorStyle: TextStyles.regular12.copyWith(color: AppColors.red),
        errorBorder: buildBorder(borderColor ?? AppColors.red),
        focusedErrorBorder: buildFocusedBorder(borderColor ?? AppColors.red),
      ),
    );
  }

  OutlineInputBorder buildBorder([Color? color]) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color ?? const Color(0xFFE6E9E9), width: 1),
      borderRadius: BorderRadius.circular(12),
    );
  }

  OutlineInputBorder buildFocusedBorder([Color? color]) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: color ?? AppColors.secondaryColor,
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }
}

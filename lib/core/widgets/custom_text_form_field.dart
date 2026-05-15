import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_text_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    this.suffixIcon,
    this.onSaved,
    this.obscureText = false,
  });

  final String hintText;
  final TextInputType keyboardType;

  final Widget? suffixIcon;
  final void Function(String?)? onSaved;

  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 342,
      height: 56,
      child: TextFormField(
        obscureText: obscureText,
        onSaved: onSaved,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
          }
          return null;
        },

        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          border: buildBorder(),
          enabledBorder: buildBorder(),
          focusedBorder: buildBorder(),
          fillColor: const Color(0xFFF9FAFA),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyles.bold13.copyWith(color: const Color(0xFF949D9E)),
        ),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: const Color(0xFFE6E9E9), width: 1),
      borderRadius: BorderRadius.circular(4),
    );
  }
}

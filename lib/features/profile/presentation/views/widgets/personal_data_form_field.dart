import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class PersonalDataFormField extends StatelessWidget {
  const PersonalDataFormField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.onSaved,
    required this.textAlign,
  });

  final String hintText;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final void Function(String?)? onSaved;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      keyboardType: keyboardType,
      textAlign: textAlign,
      validator: (value) {
        if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
        return null;
      },
      decoration: InputDecoration(
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
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _focusedBorder(),
        errorBorder: _border(),
        focusedErrorBorder: _focusedBorder(),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFFE6E9E9)),
      borderRadius: BorderRadius.circular(12),
    );
  }

  OutlineInputBorder _focusedBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xFF6BBF26), width: 1.5),
      borderRadius: BorderRadius.circular(12),
    );
  }
}

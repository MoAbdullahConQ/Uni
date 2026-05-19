import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_text_style.dart';

class SecurityPasswordField extends StatefulWidget {
  const SecurityPasswordField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.controller,
    this.onChanged,
    this.validator,
  });
  
  final String hintText;
  final IconData prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  @override
  State<SecurityPasswordField> createState() => _SecurityPasswordFieldState();
}

class _SecurityPasswordFieldState extends State<SecurityPasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      onChanged: widget.onChanged,
      validator:
          widget.validator ??
          (value) {
            if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
            return null;
          },
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyles.regular13.copyWith(
          color: const Color(0xFF9CA3AF),
          letterSpacing: 4,
        ),
        prefixIcon: Icon(
          widget.prefixIcon,
          size: 20,
          color: const Color(0xFF9CA3AF),
        ),
        suffixIcon: IconButton(
          onPressed: () => setState(() => _obscure = !_obscure),
          icon: Icon(
            _obscure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 20,
            color: const Color(0xFF9CA3AF),
          ),
        ),
        filled: true,
        fillColor: const Color(0xFFF9FAFA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
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

  OutlineInputBorder _border() => OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFFE6E9E9)),
    borderRadius: BorderRadius.circular(12),
  );

  OutlineInputBorder _focusedBorder() => OutlineInputBorder(
    borderSide: const BorderSide(color: Color(0xFF6BBF26), width: 1.5),
    borderRadius: BorderRadius.circular(12),
  );
}

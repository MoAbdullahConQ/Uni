import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/widgets/custom_text_form_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSaved,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.onChanged,
    this.validator,
    required this.textAlign,
    required this.keyboardType,
  });

  final String hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextAlign textAlign;
  final TextInputType keyboardType;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    obscureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      hintText: widget.hintText,
      prefixIcon: widget.prefixIcon,
      keyboardType: widget.keyboardType,
      textAlign: widget.textAlign,
      obscureText: obscureText,
      onSaved: widget.onSaved,

      suffixIcon: IconButton(
        onPressed: () {
          obscureText = !obscureText;
          setState(() {});
        },
        icon: Icon(
          obscureText
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          size: 20,
          color: AppColors.primaryColor.withOpacity(.6),
        ),
      ),
    );
  }
}

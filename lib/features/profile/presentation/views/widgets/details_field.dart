import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_text_style.dart';

class DetailsField extends StatelessWidget {
  const DetailsField({super.key, this.controller});

  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: 4,
      textAlign: TextAlign.right,
      validator: (v) {
        if (v == null || v.isEmpty) return 'هذا الحقل مطلوب';
        return null;
      },
      decoration: InputDecoration(
        hintText: 'كيف يمكننا مساعدتك اليوم؟',
        hintStyle: TextStyles.regular13.copyWith(
          color: const Color(0xFF9CA3AF),
        ),
        filled: true,
        fillColor: const Color(0xFFF9FAFA),
        contentPadding: const EdgeInsets.all(14),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE6E9E9)),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE6E9E9)),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF6BBF26), width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

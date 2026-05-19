import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_text_style.dart';

class TopicDropdown extends StatefulWidget {
  const TopicDropdown({super.key, required this.topics});

  final List<String> topics;

  @override
  State<TopicDropdown> createState() => _TopicDropdownState();
}

class _TopicDropdownState extends State<TopicDropdown> {
  String? selectedTopic;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedTopic,
      hint: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(Icons.info_outline, size: 16, color: Color(0xFF9CA3AF)),
          const SizedBox(width: 8),
          Text(
            'اختر الموضوع',
            style: TextStyles.regular13.copyWith(
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF9FAFA),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE6E9E9)),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE6E9E9)),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      items: widget.topics
          .map((t) => DropdownMenuItem(value: t, child: Text(t)))
          .toList(),
      onChanged: (v) => setState(() => selectedTopic = v),
      validator: (v) => v == null ? 'الرجاء اختيار الموضوع' : null,
    );
  }
}

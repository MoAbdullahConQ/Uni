import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_text_style.dart';

class PersonalDataDocumentUploadCard extends StatelessWidget {
  final String label;

  const PersonalDataDocumentUploadCard({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: open file picker
      },
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFA),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFE6E9E9),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_upload_outlined,
              size: 28,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 6),
            Text(
              // 'أضغط لرفع الملفات',
              label,
              style: TextStyles.regular14.copyWith(color: Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }
}

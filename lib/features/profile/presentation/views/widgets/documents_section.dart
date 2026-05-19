import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/profile/presentation/views/widgets/personal_data_document_upload_card.dart';

class DocumentsSection extends StatelessWidget {
  const DocumentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'مستندات مهمة',
              style: TextStyles.bold16.copyWith(color: AppColors.red),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.warning_amber_rounded,
              color: AppColors.red,
              size: 18,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '*الرجاء مراجعة جودة الصور في الرفع لانه سوف يتم اعتمادها رسمياََ',
          style: TextStyles.regular12.copyWith(color: AppColors.subtitleColor),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Checkbox(
              value: false,
              onChanged: (_) {},
              activeColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .7,
              child: Text(
                'أقر انا بأن كل المعلومات الموجودة في الاسفل صحيحه علي مسؤليتي',
                style: TextStyles.regular13.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        const PersonalDataDocumentUploadCard(label: 'شهادة الثانوية العامة'),
        const SizedBox(height: 32),
        const PersonalDataDocumentUploadCard(label: 'بطاقة الرقم القومي (وجه)'),
        const SizedBox(height: 32),
        const PersonalDataDocumentUploadCard(label: 'بطاقة الرقم القومي (ظهر)'),
        const SizedBox(height: 32),
        const PersonalDataDocumentUploadCard(label: 'شهادة الميلاد'),
        const SizedBox(height: 32),
        const PersonalDataDocumentUploadCard(label: 'صورة شخصية خلفية بيضاء'),
      ],
    );
  }
}

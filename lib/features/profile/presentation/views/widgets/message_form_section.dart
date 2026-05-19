import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/core/widgets/custom_text_form_field.dart';
import 'package:uni/features/profile/presentation/views/widgets/details_field.dart';
import 'package:uni/features/profile/presentation/views/widgets/personal_data_field_label.dart';
import 'package:uni/features/profile/presentation/views/widgets/topic_dropdown.dart';

class MessageFormSection extends StatelessWidget {
  const MessageFormSection({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.topics,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final List<String> topics;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF3F4F6)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            const PersonalDataFieldLabel(label: 'الاسم'),
            const SizedBox(height: 8),
            const CustomTextFormField(
              hintText: 'اكتب اسمك بالكامل',
              prefixIcon: Icons.person_outline,
              keyboardType: TextInputType.name,
              textAlign: TextAlign.start,
            ),

            const SizedBox(height: 16),

            const PersonalDataFieldLabel(label: 'موضوع الرسالة'),
            const SizedBox(height: 8),
            TopicDropdown(topics: topics),

            const SizedBox(height: 16),

            const PersonalDataFieldLabel(label: 'التفاصيل'),
            const SizedBox(height: 8),
            const DetailsField(),

            const SizedBox(height: 16),

            // ── Send button ──
            CustomButton(
              backgroundColor: AppColors.primaryColor,
              style: TextStyles.bold14.copyWith(
                color: AppColors.secondaryColor,
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: dispatch send message event
                }
              },
              text: 'إرسال الرسالة',
            ),
          ],
        ),
      ),
    );
  }
}

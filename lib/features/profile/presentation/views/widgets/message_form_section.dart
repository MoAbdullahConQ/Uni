import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/core/widgets/custom_text_form_field.dart';
import 'package:uni/features/profile/presentation/views/widgets/details_field.dart';
import 'package:uni/core/widgets/field_label.dart';
import 'package:uni/features/profile/presentation/views/widgets/topic_dropdown.dart';

class MessageFormSection extends StatefulWidget {
  const MessageFormSection({
    super.key,
    required this.formKey,
    required this.topics,
  });

  final GlobalKey<FormState> formKey;
  final List<String> topics;

  @override
  State<MessageFormSection> createState() => _MessageFormSectionState();
}

class _MessageFormSectionState extends State<MessageFormSection> {
  final _nameController = TextEditingController();
  final _detailsController = TextEditingController();
  String? _selectedTopic;

  @override
  void dispose() {
    _nameController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  void _submit() {
    // manual name check before form validation to avoid focus-jump after reset
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('من فضلك اكتب اسمك')));
      return;
    }

    // if (!widget.formKey.currentState!.validate()) return;

    widget.formKey.currentState!.reset();
    setState(() {
      _nameController.clear();
      _detailsController.clear();
      _selectedTopic = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم إرسال رسالتك، سنتواصل معك قريباً 👋'),
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
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
            const FieldLabel(label: 'الاسم'),
            const SizedBox(height: 8),
            CustomTextFormField(
              controller: _nameController,
              hintText: 'اكتب اسمك بالكامل',
              prefixIcon: Icon(
                Icons.person_outline,
                size: 24,
                color: AppColors.primaryColor.withOpacity(.5),
              ),
              keyboardType: TextInputType.name,
              textAlign: TextAlign.start,
              // validator removed — manual check in _submit() handles this
            ),
            const SizedBox(height: 16),

            const FieldLabel(label: 'موضوع الرسالة'),
            const SizedBox(height: 8),
            TopicDropdown(
              topics: widget.topics,
              selectedTopic: _selectedTopic,
              onChanged: (val) => setState(() => _selectedTopic = val),
            ),
            const SizedBox(height: 16),

            const FieldLabel(label: 'التفاصيل'),
            const SizedBox(height: 8),
            DetailsField(controller: _detailsController),
            const SizedBox(height: 16),

            CustomButton(
              backgroundColor: AppColors.primaryColor,
              style: TextStyles.bold14.copyWith(
                color: AppColors.secondaryColor,
              ),
              onPressed: _submit,
              text: 'إرسال الرسالة',
            ),
          ],
        ),
      ),
    );
  }
}

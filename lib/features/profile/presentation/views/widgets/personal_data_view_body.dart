import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/core/widgets/custom_text_form_field.dart';
import 'package:uni/features/profile/presentation/views/widgets/avatar_profile.dart';
import 'package:uni/features/profile/presentation/views/widgets/documents_section.dart';
import 'package:uni/features/profile/presentation/views/widgets/personal_data_field_label.dart';
import 'package:uni/features/profile/presentation/views/widgets/personal_data_interests_selector.dart';
import 'package:uni/features/profile/presentation/views/widgets/personal_data_study_type_selector.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:uni/features/profile/presentation/views/widgets/stats_Section.dart';

class PersonalDataViewBody extends StatefulWidget {
  const PersonalDataViewBody({super.key});

  @override
  State<PersonalDataViewBody> createState() => _PersonalDataViewBodyState();
}

class _PersonalDataViewBodyState extends State<PersonalDataViewBody> {
  final _formKey = GlobalKey<FormState>();

  String studyCategory = 'علمي';
  String studyTrack = 'رياضة';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        children: [
          const SizedBox(height: kTopPadding),
          ProfileHeader(
            textHeader: 'تعديل البيانات',
            textStyle: TextStyles.regular20.copyWith(
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: AppColors.borderColor),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 24),

                    // ── Avatar ──
                    const AvatarProfile(),
                    const SizedBox(height: 30),

                    // ── Name ──
                    const PersonalDataFieldLabel(label: 'الاسم بالكامل'),
                    const SizedBox(height: 8),
                    const CustomTextFormField(
                      hintText: 'مجدي عبدالغني',
                      prefixIcon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 16),

                    // ── Email──
                    const PersonalDataFieldLabel(label: 'البريد الإلكتروني'),
                    const SizedBox(height: 8),
                    const CustomTextFormField(
                      hintText: 'ahmed.m@example.com',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.end,
                    ),
                    const SizedBox(height: 16),

                    // ── الشعبة الدراسية ──
                    const PersonalDataFieldLabel(label: 'الشعبة الدراسية'),
                    const SizedBox(height: 6),
                    PersonalDataStudyTypeSelector(
                      options: const ['أدبي', 'علمي'],
                      selected: studyCategory,
                      onSelected: (v) => setState(() => studyCategory = v),
                    ),
                    const SizedBox(height: 16),

                    // ── الشعبة العلمية ──
                    const PersonalDataFieldLabel(label: 'الشعبة العلمية'),
                    const SizedBox(height: 6),
                    PersonalDataStudyTypeSelector(
                      options: const ['علوم', 'رياضة'],
                      selected: studyTrack,
                      onSelected: (v) => setState(() => studyTrack = v),
                    ),
                    const SizedBox(height: 16),

                    // ── Row: عمر / نسبة / محافظة ──
                    const StatsSection(),
                    const SizedBox(height: 16),

                    // ── مجالات الاهتمام ──
                    const PersonalDataFieldLabel(label: 'مجالات الاهتمام'),
                    const SizedBox(height: 6),
                    const PersonalDataInterestsSelector(),
                    const SizedBox(height: 24),

                    // ── مستندات مهمة ──
                    const DocumentsSection(),
                    const SizedBox(height: 32),

                    // ── حفظ التعديلات ──
                    CustomButton(
                      backgroundColor: AppColors.secondaryColor,
                      style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // TODO: dispatch save event
                        }
                      },
                      text: 'حفظ التعديلات',
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/core/widgets/custom_text_form_field.dart';
import 'package:uni/core/widgets/field_label.dart';
import 'package:uni/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:uni/features/profile/presentation/views/widgets/avatar_profile.dart';
import 'package:uni/features/profile/presentation/views/widgets/documents_section.dart';
import 'package:uni/features/profile/presentation/views/widgets/personal_data_interests_selector.dart';
import 'package:uni/core/widgets/study_type_selector.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:uni/features/profile/presentation/views/widgets/stats_Section.dart';

class PersonalDataViewBody extends StatefulWidget {
  const PersonalDataViewBody({super.key});

  @override
  State<PersonalDataViewBody> createState() => _PersonalDataViewBodyState();
}

class _PersonalDataViewBodyState extends State<PersonalDataViewBody> {
  final _formKey = GlobalKey<FormState>();

  int? selectedGovernorateId;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _percentageController = TextEditingController();
  final _ageController = TextEditingController();

  String studyCategory = 'علمي';
  String studyTrack = 'رياضة';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      bloc: getIt<ProfileCubit>(),
      listenWhen: (previous, current) =>
          current is StudentInfoSaved ||
          current is SaveStudentInfoFailure ||
          (current is ProfileSuccess),
      listener: (context, state) {
        if (state is StudentInfoSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم حفظ التعديلات بنجاح'),
              backgroundColor: AppColors.primaryColor,
            ),
          );
        } else if (state is SaveStudentInfoFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: AppColors.red,
            ),
          );
        } else if (state is ProfileSuccess) {}
      },
      builder: (context, state) {
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

                        // ── Name (read-only — no update-profile endpoint yet) ──
                        const FieldLabel(label: 'الاسم بالكامل'),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          controller: _nameController,
                          enabled: false,
                          hintText: 'مجدي عبدالغني',
                          prefixIcon: Icon(
                            Icons.person_outline,
                            size: 24,
                            color: AppColors.primaryColor.withOpacity(.5),
                          ),
                          keyboardType: TextInputType.name,
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 16),

                        // ── Email (read-only — no update-profile endpoint yet) ──
                        const FieldLabel(label: 'البريد الإلكتروني'),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          controller: _emailController,
                          enabled: false,
                          hintText: 'ahmed.m@example.com',
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            size: 24,
                            color: AppColors.primaryColor.withOpacity(.5),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textAlign: TextAlign.end,
                        ),
                        const SizedBox(height: 16),

                        // ── الشعبة الدراسية ──
                        const FieldLabel(label: 'الشعبة الدراسية'),
                        const SizedBox(height: 6),
                        StudyTypeSelector(
                          options: const ['أدبي', 'علمي'],
                          selected: studyCategory,
                          onSelected: (v) => setState(() => studyCategory = v),
                        ),
                        const SizedBox(height: 16),

                        // ── الشعبة العلمية ──
                        const FieldLabel(label: 'الشعبة العلمية'),
                        const SizedBox(height: 6),
                        StudyTypeSelector(
                          options: const ['علوم', 'رياضة'],
                          selected: studyTrack,
                          onSelected: (v) => setState(() => studyTrack = v),
                        ),
                        const SizedBox(height: 16),

                        // ── Row: عمر / نسبة / محافظة ──
                        StatsSection(
                          selectedGovernorateId: selectedGovernorateId,
                          onGovernorateChanged: (id) =>
                              setState(() => selectedGovernorateId = id),
                          percentageController: _percentageController,
                          ageController: _ageController,
                        ),
                        const SizedBox(height: 16),

                        // ── مجالات الاهتمام ──
                        const FieldLabel(label: 'مجالات الاهتمام'),
                        const SizedBox(height: 6),
                        const PersonalDataInterestsSelector(),
                        const SizedBox(height: 24),

                        // ── مستندات مهمة ──
                        const DocumentsSection(),
                        const SizedBox(height: 32),

                        // ── حفظ التعديلات ──
                        CustomButton(
                          backgroundColor: AppColors.secondaryColor,
                          style: TextStyles.bold16.copyWith(
                            color: AppColors.primaryColor,
                          ),
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
      },
    );
  }
}

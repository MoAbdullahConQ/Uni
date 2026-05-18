import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_text_form_field.dart';
import 'package:uni/features/profile/presentation/views/widgets/avatar_profile.dart';
import 'package:uni/features/profile/presentation/views/widgets/personal_data_field_label.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_header.dart';

class PersonalDataViewBody extends StatefulWidget {
  const PersonalDataViewBody({super.key});

  @override
  State<PersonalDataViewBody> createState() => _PersonalDataViewBodyState();
}

class _PersonalDataViewBodyState extends State<PersonalDataViewBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: Column(
        children: [
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 24),

                    // ── Avatar ──
                    AvatarProfile(),
                    SizedBox(height: 30),

                    // ── Name ──
                    PersonalDataFieldLabel(label: 'الاسم بالكامل'),
                    SizedBox(height: 8),
                    CustomTextFormField(
                      hintText: 'مجدي عبدالغني',
                      prefixIcon: Icons.person_outline,
                      keyboardType: TextInputType.name,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 16),

                    // ── Email──
                    PersonalDataFieldLabel(label: 'البريد الإلكتروني'),
                    SizedBox(height: 8),
                    CustomTextFormField(
                      hintText: 'ahmed.m@example.com',
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(height: 16),
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

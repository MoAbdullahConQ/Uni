import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/features/profile/presentation/views/widgets/password_section.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:uni/features/profile/presentation/views/widgets/top_section_security.dart';

class SecurityViewBody extends StatefulWidget {
  const SecurityViewBody({super.key});

  @override
  State<SecurityViewBody> createState() => _SecurityViewBodyState();
}

class _SecurityViewBodyState extends State<SecurityViewBody> {
  final _formKey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        children: [
          const SizedBox(height: kTopPadding),
          ProfileHeader(
            textHeader: 'الأمان وكلمة المرور',
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
                  children: [
                    const SizedBox(height: 32),

                    // ── Shield icon + description ──
                    const TopSectionSecurity(),
                    const SizedBox(height: 40),
                    PasswordSection(
                      newPasswordController: newPasswordController,
                      confirmPasswordController: confirmPasswordController,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Bottom button ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
            child: CustomButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // TODO: dispatch update password event
                }
              },
              text: 'تحديث كلمة المرور',
              backgroundColor: AppColors.secondaryColor,
              style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

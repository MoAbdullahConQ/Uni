import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/password_field.dart';
import 'package:uni/features/profile/presentation/views/widgets/personal_data_field_label.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:uni/features/profile/presentation/views/widgets/top_section_security.dart';

class SecurityViewBody extends StatelessWidget {
  const SecurityViewBody({super.key});

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
              child: Column(
                children: [
                  const SizedBox(height: 32),

                  // ── Shield icon + description ──
                  const TopSectionSecurity(),
                  const SizedBox(height: 32),

                  // ── كلمة المرور الحالية ──
                  const PersonalDataFieldLabel(label: 'كلمة المرور الحالية'),
                  const SizedBox(height: 8),
                  const PasswordField(
                    hintText: '••••••••',
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock_outline,
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'نسيت كلمة المرور؟',
                        style: TextStyles.regular12.copyWith(
                          color: AppColors.subtitleColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/core/helper_functions/calc_strength.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/password_field.dart';
import 'package:uni/features/profile/presentation/views/widgets/personal_data_field_label.dart';
import 'package:uni/features/profile/presentation/views/widgets/security_strength_indicator.dart';

class PasswordSection extends StatefulWidget {
  const PasswordSection({
    super.key,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  @override
  State<PasswordSection> createState() => _PasswordSectionState();
}

class _PasswordSectionState extends State<PasswordSection> {
  double passwordStrength = 0.5; // 0.0 → 1.0
  bool? passwordsMatch;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ── nowPasswordController──
        const PersonalDataFieldLabel(label: 'كلمة المرور الحالية'),
        const SizedBox(height: 8),
        PasswordField(
          hintText: '••••••••',
          textAlign: TextAlign.start,
          keyboardType: TextInputType.visiblePassword,
          prefixIcon: const Icon(Icons.lock_outline, size: 24),
          borderColor: AppColors.primaryColor.withOpacity(.1),
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
        const SizedBox(height: 30),

        // ── newPasswordController ──
        const PersonalDataFieldLabel(label: 'كلمة المرور الجديدة'),
        const SizedBox(height: 8),
        PasswordField(
          hintText: '••••••••',
          prefixIcon: const Icon(Icons.lock_outline, size: 24),

          controller: widget.newPasswordController,
          borderColor: AppColors.primaryColor.withOpacity(.1),
          onChanged: (value) {
            setState(() {
              passwordStrength = calcStrength(value);
            });
          },
          textAlign: TextAlign.start,
          keyboardType: TextInputType.visiblePassword,
        ),
        const SizedBox(height: 8),

        // ── Strength indicator ──
        SecurityStrengthIndicator(strength: passwordStrength),
        const SizedBox(height: 24),

        // ── confirmPasswordController ──
        const PersonalDataFieldLabel(label: 'تأكيد كلمة المرور الجديدة'),
        const SizedBox(height: 8),
        PasswordField(
          hintText: '••••••••',
          prefixIcon: const Icon(Icons.lock_outline, size: 24),
          controller: widget.confirmPasswordController,
          onChanged: (value) {
            setState(() {
              if (value.isEmpty) {
                passwordsMatch = null;
              } else {
                passwordsMatch = value == widget.newPasswordController.text;
              }
            });
          },
          borderColor: passwordsMatch == null
              ? null
              : passwordsMatch!
              ? AppColors.secondaryColor
              : AppColors.red,
          validator: (value) {
            if (value != widget.newPasswordController.text) {
              return '';
            }
            return null;
          },
          textAlign: TextAlign.start,
          keyboardType: TextInputType.visiblePassword,
        ),
        if (passwordsMatch != null)
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              passwordsMatch!
                  ? 'كلمتا المرور متطابقتان ✓'
                  : 'كلمتا المرور غير متطابقتين',
              style: TextStyles.regular12.copyWith(
                color: passwordsMatch!
                    ? const Color(0xFF6BBF26)
                    : AppColors.red,
              ),
            ),
          ),
        const SizedBox(height: 24),
      ],
    );
  }
}

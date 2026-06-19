import 'package:flutter/material.dart';
import 'package:uni/core/helper_functions/calc_strength.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/field_label.dart';
import 'package:uni/core/widgets/password_field.dart';
import 'package:uni/core/widgets/security_strength_indicator.dart';

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
  double passwordStrength = 0; // 0.0 → 1.0
  bool? passwordsMatch;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // current-password field removed: user is already authenticated via
        // the bearer token, and the update-password endpoint has no
        // current_password param. Ask sayed before reintroducing this.

        // ── newPasswordController ──
        const FieldLabel(label: 'كلمة المرور الجديدة'),
        const SizedBox(height: 8),
        PasswordField(
          hintText: '••••••••',
          prefixIcon: Icon(
            Icons.lock_outline,
            size: 20,
            color: AppColors.primaryColor.withOpacity(.6),
          ),
          controller: widget.newPasswordController,
          onChanged: (value) {
            setState(() {
              passwordStrength = calcStrength(value);
              // re-validate match against the (possibly already filled) confirm field
              passwordsMatch = widget.confirmPasswordController.text.isEmpty
                  ? null
                  : value == widget.confirmPasswordController.text;
            });
          },
          textAlign: TextAlign.start,
          keyboardType: TextInputType.visiblePassword,
          validator: (value) {
            if (value == null || value.length < 8) {
              return 'كلمة المرور يجب أن تكون 8 أحرف على الأقل';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),

        // ── Strength indicator ──
        SecurityStrengthIndicator(strength: passwordStrength),
        const SizedBox(height: 24),

        // ── confirmPasswordController ──
        const FieldLabel(label: 'تأكيد كلمة المرور الجديدة'),
        const SizedBox(height: 8),
        PasswordField(
          hintText: '••••••••',
          prefixIcon: Icon(
            Icons.lock_outline,
            size: 20,
            color: AppColors.primaryColor.withOpacity(.6),
          ),
          controller: widget.confirmPasswordController,
          onChanged: (value) {
            setState(() {
              passwordsMatch = value.isEmpty
                  ? null
                  : value == widget.newPasswordController.text;
            });
          },
          borderColor: passwordsMatch == null
              ? null
              : passwordsMatch!
              ? AppColors.secondaryColor
              : AppColors.red,
          // validator only checks required — match is enforced in _submit()
          validator: (value) {
            if (value == null || value.isEmpty) return 'هذا الحقل مطلوب';
            return null;
          },
          textAlign: TextAlign.start,
          keyboardType: TextInputType.visiblePassword,
        ),
        if (passwordsMatch != null) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(right: 6),
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
        ],
        const SizedBox(height: 24),
      ],
    );
  }
}

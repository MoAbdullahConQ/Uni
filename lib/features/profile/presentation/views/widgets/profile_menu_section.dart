import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/profile/presentation/views/personal_data_view.dart';
import 'package:uni/features/profile/presentation/views/security_view.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_menu_item.dart';

class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── إعدادات الحساب ──
        Text(
          'إعدادات الحساب',
          style: TextStyles.bold14.copyWith(
            color: AppColors.primaryColor.withOpacity(.6),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFF3F4F6)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              ProfileMenuItem(
                icon: Icons.person_outline,
                label: 'البيانات الشخصية',
                onTap: () {
                  Navigator.pushNamed(context, PersonalDataView.routeName);
                },
              ),
              const Divider(
                height: 1,
                indent: 16,
                endIndent: 16,
                color: AppColors.borderColor,
              ),
              ProfileMenuItem(
                icon: Icons.shield_outlined,
                label: 'الأمان وكلمة المرور',
                onTap: () {
                  Navigator.pushNamed(context, SecurityView.routeName);
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ── الدعم والمساعدة ──
        Text(
          'الدعم والمساعدة',
          style: TextStyles.bold14.copyWith(
            color: AppColors.primaryColor.withOpacity(.6),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFF3F4F6)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ProfileMenuItem(
            icon: Icons.headphones_outlined,
            label: 'تواصل مع الدعم',
            iconBackgroundColor: AppColors.secondaryColor,
            iconColor: AppColors.primaryColor,
            onTap: () {
              // TODO: navigate to contact us screen
            },
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/profile/presentation/views/widgets/avatar_profile.dart';
import 'package:uni/features/profile/presentation/views/widgets/role_badge.dart';

class ProfileAvatarSection extends StatelessWidget {
  final String name;
  final String email;
  final String role;

  const ProfileAvatarSection({
    super.key,
    required this.name,
    required this.email,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AvatarProfile(),
        const SizedBox(height: 12),
        Text(
          name,
          style: TextStyles.bold24.copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: TextStyles.semiBold13.copyWith(
            color: AppColors.primaryColor.withOpacity(.6),
          ),
        ),
        const SizedBox(height: 10),
        RoleBadge(role: role),
      ],
    );
  }
}

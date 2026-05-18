import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_avatar_section.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_logout_button.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_menu_section.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileHeader(),
          SizedBox(height: 10),
          Divider(height: 1, color: AppColors.borderColor),
          SizedBox(height: 24),
          ProfileAvatarSection(
            name: 'مجدي عبد الغني',
            email: 'ahmed.m@example.com',
            role: 'طالب - علمي رياضة',
          ),
          SizedBox(height: 24),
          ProfileMenuSection(),
          SizedBox(height: 24),
          ProfileLogoutButton(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_avatar_section.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_logout_button.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_menu_section.dart';
import 'package:uni/features/profile/presentation/views/widgets/version_info.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        children: [
          const SizedBox(height: kTopPadding),
          ProfileHeader(
            textHeader: 'الملف الشخصي',
            textStyle: TextStyles.bold20.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(height: 10),
          const Divider(height: 1, color: AppColors.borderColor),
          const Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  VersionInfo(),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

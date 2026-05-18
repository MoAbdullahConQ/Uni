import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_avatar_section.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_header.dart';

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
          SizedBox(height: 24),
          ProfileAvatarSection(
            name: 'مجدي عبد الغني',
            email: 'ahmed.m@example.com',
            role: 'طالب - علمي رياضة',
          ),
        ],
      ),
    );
  }
}

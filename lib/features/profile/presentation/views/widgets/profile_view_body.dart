import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_error_widget.dart';
import 'package:uni/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:uni/features/profile/presentation/views/widgets/logout_confirmation_sheet.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_avatar_section.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_header.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_logout_button.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_menu_section.dart';
import 'package:uni/features/profile/presentation/views/widgets/version_info.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  @override
  void initState() {
    super.initState();
    getIt<ProfileCubit>().getMe();
  }

  // builds the role label displayed in RoleBadge from the raw backend values.
  String _buildRole(dynamic studentInfo) {
    if (studentInfo == null) return 'طالب';
    final sectionMap = {
      'science': 'علمي',
      'علمي': 'علمي',
      'literature': 'أدبي',
      'أدبي': 'أدبي',
    };
    final deptMap = {
      'scientific': 'علوم',
      'علوم': 'علوم',
      'Mathematics': 'رياضة',
      'رياضة': 'رياضة',
    };
    final section = sectionMap[studentInfo.studySection] ?? 'علمي';
    final dept = deptMap[studentInfo.scientificDepartment] ?? '';
    return dept.isNotEmpty ? 'طالب - $section $dept' : 'طالب - $section';
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: getIt<ProfileCubit>(),
      builder: (context, state) {
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
              Expanded(child: _buildBody(state)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody(ProfileState state) {
    if (state is ProfileLoading || state is ProfileInitial) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    }

    if (state is ProfileFailure) {
      return Center(
        child: CustomErrorWidget(
          message: state.errMessage,
          onRetry: () => getIt<ProfileCubit>().getMe(),
        ),
      );
    }

    // covers ProfileSuccess, SavingStudentInfo, StudentInfoSaved,
    // SaveStudentInfoFailure, UpdatingPassword, PasswordUpdated,
    // UpdatePasswordFailure — all keep the user data visible.
    final user = state is ProfileSuccess
        ? state.user
        : (getIt<ProfileCubit>().currentUser);

    if (user == null) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryColor),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          ProfileAvatarSection(
            name: user.name,
            email: user.email,
            role: _buildRole(user.studentInfo),
          ),
          const SizedBox(height: 24),
          const ProfileMenuSection(),
          const SizedBox(height: 24),
          ProfileLogoutButton(
            onPressed: () => LogoutConfirmationSheet.show(
              context,
              onConfirm: () => getIt<ProfileCubit>().logout(),
            ),
          ),
          const SizedBox(height: 24),
          const VersionInfo(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

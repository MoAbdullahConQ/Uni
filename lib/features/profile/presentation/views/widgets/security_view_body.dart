import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
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

  void _submit() {
    if (_formKey.currentState!.validate()) {
      getIt<ProfileCubit>().updatePassword(
        password: newPasswordController.text,
        passwordConfirmation: confirmPasswordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      bloc: getIt<ProfileCubit>(),
      listenWhen: (previous, current) =>
          current is PasswordUpdated || current is UpdatePasswordFailure,
      listener: (context, state) {
        if (state is PasswordUpdated) {
          newPasswordController.clear();
          confirmPasswordController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تحديث كلمة المرور بنجاح'),
              backgroundColor: AppColors.primaryColor,
            ),
          );
        } else if (state is UpdatePasswordFailure) {
          // if 401, the ApiService interceptor will redirect to LoginView — skip the snackbar
          if (state.errMessage.toLowerCase().contains('unauthenticated'))
            return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final isUpdating = state is UpdatingPassword;
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
                        // current-password field removed: user is already
                        // authenticated via the bearer token, no endpoint param for it.
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
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding,
                ),
                child: CustomButton(
                  onPressed: isUpdating ? () {} : _submit,
                  text: isUpdating ? '' : 'تحديث كلمة المرور',
                  backgroundColor: AppColors.secondaryColor,
                  prefixIcon: isUpdating
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.primaryColor,
                          ),
                        )
                      : null,
                  style: TextStyles.bold16.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }
}

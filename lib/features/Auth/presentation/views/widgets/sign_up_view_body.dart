import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:uni/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:uni/features/auth/presentation/views/widgets/have_account_row.dart';
import 'package:uni/features/auth/presentation/views/widgets/sign_up_form.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          print('signup=============================$state');
          //otp
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errMessage),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kTopPadding,
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 50),
              const AuthHeader(
                title: 'إنشاء حساب جديد 🚀',
                subtitle: 'إملئ جميع بياناتك لتبدأ رحلتك التعليمية معنا',
              ),
              const SizedBox(height: 32),

              SignUpForm(onEmailChanged: (String value) {}),
              const SizedBox(height: 24),

              const HaveAccountRow(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

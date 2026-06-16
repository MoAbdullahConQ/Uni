import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:uni/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:uni/features/auth/presentation/views/widgets/forget_form.dart';

class ForgotPasswordViewBody extends StatelessWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          print('=========go otp====================$state');
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          children: [
            const SizedBox(height: 56),
            AuthHeader(
              title: 'نسيت كلمة المرور؟',
              subtitle:
                  'متقلقش، دخل بريدك الإلكتروني وهنبعتلك رمز لإعادة التعيين.',
              showLogo: true,
              borderRadius: 30,
              colorContainer: AppColors.primaryColor,
              horizontalPaddingContainer: 30,
              verticalPaddingContainer: 30,
              childContainer: SvgPicture.asset(Assets.imagesKey, height: 40),
            ),
            const SizedBox(height: 32),
            const ForgetForm(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

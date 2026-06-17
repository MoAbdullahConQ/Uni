import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_fonts.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/features/auth/presentation/manager/auth_cubit/auth_cubit.dart';
import 'package:uni/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:uni/features/auth/presentation/views/widgets/login_form.dart';
import 'package:uni/features/auth/presentation/views/widgets/no_Account_row.dart';
import 'package:uni/features/auth/presentation/views/widgets/or_divider.dart';
import 'package:uni/features/home/presentation/views/main_view.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  void initState() {
    super.initState();
    // show session-expired message if navigated here from 401 interceptor.
    // read from route arguments only — each navigation owns its own message,
    // nothing is left "pending" across sessions/navigations.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      final message = args as String?;
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: AppColors.red),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainView.routeName,
            (route) => false,
          );
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
              // header: logo + title + subtitle
              AuthHeader(
                borderRadius: 22,
                title: 'أهلاً برجوعك 👋',
                subtitle: 'سجل الدخول وابداء رحلتك الجامعية',
                showLogo: true,
                verticalPaddingContainer: 8,
                horizontalPaddingContainer: 16,
                colorContainer: AppColors.primaryColor,
                childContainer: Column(
                  children: [
                    SvgPicture.asset(Assets.imagesLogo, height: 36),
                    Text(
                      'جامعتي',
                      textAlign: TextAlign.center,
                      style: TextStyles.regular16.copyWith(
                        color: AppColors.lightSecondaryColor,
                        fontFamily: AppFonts.palestineFont,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // login form
              const LoginForm(),
              const SizedBox(height: 24),

              // divider
              const OrDivider(),
              const SizedBox(height: 16),

              // social buttons
              CustomButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Not Available Now',
                        textAlign: TextAlign.center,
                        style: TextStyles.regular16,
                      ),
                      backgroundColor: AppColors.primaryColor,
                    ),
                  );
                },
                text: 'Google',
                borderColor: AppColors.borderColor,
                style: TextStyles.bold16.copyWith(
                  color: AppColors.primaryColor,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: SvgPicture.asset(Assets.imagesGoogle, height: 20),
                ),
              ),
              const SizedBox(height: 24),

              // no account row
              const NoAccountRow(),
              const SizedBox(height: 26),
            ],
          ),
        ),
      ),
    );
  }
}

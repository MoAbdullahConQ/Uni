import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/features/auth/presentation/views/widgets/auth_header.dart';
import 'package:uni/features/auth/presentation/views/widgets/sign_up_form.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          ],
        ),
      ),
    );
  }
}

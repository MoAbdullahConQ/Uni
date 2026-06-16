import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/features/auth/presentation/views/widgets/auth_header.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            AuthHeader(
              title: 'إنشاء حساب جديد 🚀',
              subtitle: 'إملئ جميع بياناتك لتبدأ رحلتك التعليمية معنا',
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

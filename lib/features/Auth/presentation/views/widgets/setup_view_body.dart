import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/features/auth/presentation/views/widgets/auth_header.dart';

class SetupViewBody extends StatelessWidget {
  const SetupViewBody({super.key});

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
            // header
            AuthHeader(
              title: 'جهز ملفك الشخصي🎓',
              subtitle: 'ساعدنا نخصص تجربتك بناءً على اهتماماتك',
            ),

            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

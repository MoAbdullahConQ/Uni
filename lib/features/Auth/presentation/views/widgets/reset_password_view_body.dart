import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/widgets/back_button.dart';
import 'package:uni/features/auth/presentation/views/widgets/verified_badge.dart';

class ResetPasswordViewBody extends StatelessWidget {
  const ResetPasswordViewBody({super.key, required this.tempToken});

  final String tempToken;

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // top row: back button + verified badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomBackButton(),
              Spacer(flex: 2),
              VerifiedBadge(),
              Spacer(flex: 3),
            ],
          ),

          SizedBox(height: 40),
        ],
      ),
    );
  }
}

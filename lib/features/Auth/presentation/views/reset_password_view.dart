import 'package:flutter/material.dart';
import 'package:uni/features/auth/presentation/views/widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.tempToken});

  static const String routeName = 'reset-password';

  final String tempToken;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: ResetPasswordViewBody(tempToken: tempToken)),
    );
  }
}

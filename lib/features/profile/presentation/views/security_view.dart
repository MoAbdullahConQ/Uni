import 'package:flutter/material.dart';
import 'package:uni/features/profile/presentation/views/widgets/security_view_body.dart';

class SecurityView extends StatelessWidget {
  const SecurityView({super.key});

  static const String routeName = 'security_view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SecurityViewBody(),
      ),
    );
  }
}

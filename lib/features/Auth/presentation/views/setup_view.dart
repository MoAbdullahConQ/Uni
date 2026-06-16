import 'package:flutter/material.dart';
import 'package:uni/features/auth/presentation/views/widgets/setup_view_body.dart';

class SetupView extends StatelessWidget {
  static const String routeName = 'setup';

  const SetupView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: SetupViewBody()));
  }
}

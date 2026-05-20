import 'package:flutter/material.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_view_body.dart';

class GuideView extends StatelessWidget {
  const GuideView({super.key});

  static const String routeName = 'guide_view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: GuideViewBody()));
  }
}

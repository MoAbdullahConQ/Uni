import 'package:flutter/material.dart';
import 'package:uni/constants.dart';

class SetupViewBody extends StatelessWidget {
  const SetupViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: Column(children: []),
    );
  }
}

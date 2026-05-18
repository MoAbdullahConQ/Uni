import 'package:flutter/material.dart';
import 'package:uni/constants.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }
}

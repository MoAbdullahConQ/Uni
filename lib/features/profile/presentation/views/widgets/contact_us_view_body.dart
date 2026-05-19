import 'package:flutter/material.dart';
import 'package:uni/constants.dart';

class ContactUsViewBody extends StatelessWidget {
  const ContactUsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(children: [SizedBox(height: kTopPadding)]),
    );
  }
}

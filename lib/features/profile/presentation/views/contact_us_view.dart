import 'package:flutter/material.dart';
import 'package:uni/features/profile/presentation/views/widgets/contact_us_view_body.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  static const String routeName = 'contact-us';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ContactUsViewBody(),
      ),
    );
  }
}

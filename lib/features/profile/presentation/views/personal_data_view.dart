import 'package:flutter/material.dart';
import 'package:uni/features/profile/presentation/views/widgets/personal_data_view_body.dart';

class PersonalDataView extends StatelessWidget {
  const PersonalDataView({super.key});

  static const String routeName = '/profile/personal-data';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PersonalDataViewBody(),
      ),
    );
  }
}

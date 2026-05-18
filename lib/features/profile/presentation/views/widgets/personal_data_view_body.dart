import 'package:flutter/material.dart';
import 'package:uni/constants.dart';

class PersonalDataViewBody extends StatefulWidget {
  const PersonalDataViewBody({super.key});

  @override
  State<PersonalDataViewBody> createState() => _PersonalDataViewBodyState();
}

class _PersonalDataViewBodyState extends State<PersonalDataViewBody> {
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: Column(),
    );
  }
}

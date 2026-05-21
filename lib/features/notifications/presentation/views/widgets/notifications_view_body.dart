import 'package:flutter/material.dart';
import 'package:uni/constants.dart';

class NotificationsViewBody extends StatelessWidget {
  const NotificationsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kTopPadding,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          
          ],
        ),
      ),
    );
  }
}

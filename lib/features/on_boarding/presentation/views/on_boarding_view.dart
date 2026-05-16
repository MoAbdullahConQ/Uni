import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/services/shared_preferences_singleton.dart';
import 'package:uni/features/home/presentation/views/home_view.dart';
import 'package:uni/features/on_boarding/presentation/views/widgets/on_boarding_view_body.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  static const String routeName = 'OnBoardingView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: OnBoardingViewBody(
            onDone: () {
              Prefs.setBool(kIsOnBoardingViewSeenKey, true);
              Navigator.pushReplacementNamed(context, HomeView.routeName);
            },
          ),
        ),
      ),
    );
  }
}

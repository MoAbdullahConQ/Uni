import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/services/shared_preferences_singleton.dart';
import 'package:uni/features/home/presentation/views/home_view.dart';
import 'package:uni/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:uni/features/splash/presentation/views/widgets/uni_logo_widget.dart';
import 'package:uni/features/splash/presentation/views/widgets/uni_text_pocket_widget.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  void initState() {
    executeNavigation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UniLogoWidget(),
          SizedBox(height: 63),
          UniTextPocketWidget(),
        ],
      ),
    );
  }

  void executeNavigation() {
    bool isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeenKey);
    Future.delayed(Duration(seconds: 2), () {
      if (!mounted) return;
      if (isOnBoardingViewSeen) {
        Navigator.pushReplacementNamed(context, HomeView.routeName);
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      }
    });
  }
}

import 'package:flutter/material.dart';
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
    // excuteNavigation();

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

  // void excuteNavigation() {
  //   bool isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeenKey);
  //   Future.delayed(Duration(seconds: 3), () {
  //     if (isOnBoardingViewSeen) {
  //       var isLoggedIn = FirebaseAuthService().isLoggedIn();
  //       if (isLoggedIn) {
  //         Navigator.pushReplacementNamed(context, MainView.routeName);
  //       } else {
  //         Navigator.pushReplacementNamed(context, SignInView.routeName);
  //       }
  //     } else {
  //       Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
  //     }
  //   });
  // }
}

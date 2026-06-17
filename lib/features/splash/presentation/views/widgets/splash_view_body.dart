import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/services/shared_preferences_singleton.dart';
import 'package:uni/features/auth/presentation/views/login_view.dart';
import 'package:uni/features/home/presentation/views/main_view.dart';
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
    return const Center(
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
    final token = Prefs.getString('token');
    final isOnBoardingViewSeen = Prefs.getBool(kIsOnBoardingViewSeenKey);

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      if (token.isNotEmpty) {
        Navigator.pushReplacementNamed(context, MainView.routeName);
      } else if (isOnBoardingViewSeen) {
        Navigator.pushReplacementNamed(context, LoginView.routeName);
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingView.routeName);
      }
    });
  }
}

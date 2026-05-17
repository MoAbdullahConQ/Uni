import 'package:flutter/material.dart';
import 'package:uni/features/home/presentation/views/main_view.dart';
import 'package:uni/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:uni/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => const SplashView());
    case OnBoardingView.routeName:
      return MaterialPageRoute(builder: (context) => const OnBoardingView());
    case MainView.routeName:
      return MaterialPageRoute(builder: (context) => const MainView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
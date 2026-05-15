
import 'package:flutter/material.dart';
import 'package:uni/features/splash/presentation/views/splash_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => SplashView());
    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}

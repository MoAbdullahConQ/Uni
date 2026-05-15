import 'package:flutter/material.dart';
import 'package:uni/core/helper_functions/on_generate_routes.dart';
import 'package:uni/core/utils/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        useMaterial3: true,
      ),

      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      // initialRoute: SplashView.routeName,
    );
  }
}

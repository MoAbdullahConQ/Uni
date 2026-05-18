import 'package:flutter/material.dart';
import 'package:uni/features/fav/presentation/views/fav_view.dart';
import 'package:uni/features/home/presentation/views/widgets/home_view.dart';
import 'package:uni/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:uni/features/profile/presentation/views/profile_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const String routeName = 'MainView';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  List<Widget> get views => [
    const HomeView(),
    const HomeView(),
    const FavView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onIndexChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: SafeArea(child: views[currentIndex]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/core/widgets/ask_faheem_button.dart';
import 'package:uni/features/fav/presentation/views/widgets/fav_view_body.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_view_body.dart';
import 'package:uni/features/home/presentation/views/widgets/custom_bottom_navigation_bar.dart';
import 'package:uni/features/home/presentation/views/widgets/home_view_body.dart';
import 'package:uni/features/profile/presentation/views/widgets/profile_view_body.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const String routeName = 'MainView';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  List<Widget> get views => [
    const HomeViewBody(),
    const GuideViewBody(),
    const FavViewBody(),
    const ProfileViewBody(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: currentIndex != 3
          ? const AskFaheemButton()
          : null,
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

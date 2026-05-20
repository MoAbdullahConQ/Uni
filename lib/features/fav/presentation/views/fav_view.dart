import 'package:flutter/material.dart';
import 'package:uni/features/fav/presentation/views/widgets/fav_view_body.dart';

class FavView extends StatelessWidget {
  const FavView({super.key});

  static const String routeName = 'fav_view';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: FavViewBody()));
  }
}

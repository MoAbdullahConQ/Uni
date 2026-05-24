import 'package:flutter/material.dart';
import 'package:uni/core/widgets/ask_faheem_button.dart';
import 'package:uni/features/browse/presentation/views/widgets/browse_view_body.dart';

class BrowseView extends StatelessWidget {
  const BrowseView({super.key});

  static const String routeName = 'browse';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      floatingActionButton: AskFaheemButton(),
      backgroundColor: Colors.white,
      body: SafeArea(child: BrowseViewBody()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/core/widgets/ask_faheem_button.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_detail_view_body.dart';

class UniDetailView extends StatelessWidget {
  static const routeName = 'uni_detail';

  const UniDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 70),
        child: AskFaheemButton(),
      ),
      body: SafeArea(child: UniDetailViewBody()),
    );
  }
}

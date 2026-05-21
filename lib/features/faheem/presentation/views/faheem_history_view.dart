import 'package:flutter/material.dart';
import 'package:uni/features/faheem/presentation/views/widgets/faheem_history_view_body.dart';

class FaheemHistoryView extends StatelessWidget {
  static const routeName = 'faheem_history';

  const FaheemHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: FaheemHistoryViewBody()),
    );
  }
}

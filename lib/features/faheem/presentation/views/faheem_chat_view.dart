import 'package:flutter/material.dart';
import 'package:uni/features/faheem/presentation/views/widgets/faheem_chat_view_body.dart';

class FaheemChatView extends StatelessWidget {
  static const routeName = 'faheem_chat';

  const FaheemChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: FaheemChatViewBody()),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/features/faheem/presentation/views/widgets/faheem_chat_app_bar.dart';

class FaheemChatViewBody extends StatefulWidget {
  const FaheemChatViewBody({super.key});

  @override
  State<FaheemChatViewBody> createState() => _FaheemChatViewBodyState();
}

class _FaheemChatViewBodyState extends State<FaheemChatViewBody> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: Column(
        children: [
          // App bar
          FaheemChatAppBar(
            showTitle: false,
            onHistoryTap: () {
              print('history tapped!');
            },
          ),

          
        ],
      ),
    );
  }
}

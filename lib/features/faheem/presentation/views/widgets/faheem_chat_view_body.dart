import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';
import 'package:uni/features/faheem/presentation/views/widgets/chat_input_bar.dart';
import 'package:uni/features/faheem/presentation/views/widgets/faheem_chat_app_bar.dart';
import 'package:uni/features/faheem/presentation/views/widgets/faheem_welcome_widget.dart';

class FaheemChatViewBody extends StatefulWidget {
  const FaheemChatViewBody({super.key});

  @override
  State<FaheemChatViewBody> createState() => _FaheemChatViewBodyState();
}

class _FaheemChatViewBodyState extends State<FaheemChatViewBody> {
  final TextEditingController _controller = TextEditingController();

  // TODO: replace with cubit
  List<ChatMessageEntity> messages = [];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(ChatMessageEntity(text: text, sender: MessageSender.user));
      _controller.clear();
    });
  }

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

          // Content
          const Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              child: FaheemWelcomeWidget(),
            ),
          ),

          // Input
          ChatInputBar(controller: _controller, onSend: _sendMessage),
        ],
      ),
    );
  }
}

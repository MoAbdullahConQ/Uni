import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';
import 'package:uni/features/faheem/presentation/views/widgets/chat_input_bar.dart';
import 'package:uni/features/faheem/presentation/views/widgets/chat_messages_list.dart';
import 'package:uni/features/faheem/presentation/views/widgets/faheem_chat_app_bar.dart';
import 'package:uni/features/faheem/presentation/views/widgets/faheem_welcome_widget.dart';

class FaheemChatViewBody extends StatefulWidget {
  const FaheemChatViewBody({super.key});

  @override
  State<FaheemChatViewBody> createState() => _FaheemChatViewBodyState();
}

class _FaheemChatViewBodyState extends State<FaheemChatViewBody> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  // TODO: replace with cubit
  late List<ChatMessageEntity> messages;

  @override
  void initState() {
    super.initState();
    messages = List.from(getDummyChatMessages());
  }

  bool get _hasMessages => messages.isNotEmpty;

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      messages.add(ChatMessageEntity(text: text, sender: MessageSender.user));
      _controller.clear();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
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
          Expanded(
            child: _hasMessages
                ? ChatMessagesList(
                    messages: messages,
                    scrollController: _scrollController,
                  )
                : const SingleChildScrollView(
                    padding: EdgeInsets.symmetric(
                      horizontal: kHorizontalPadding,
                    ),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/features/faheem/presentation/manager/faheem_cubit/faheem_cubit.dart';
import 'package:uni/features/faheem/presentation/manager/faheem_cubit/faheem_state.dart';
import 'package:uni/features/faheem/presentation/views/faheem_history_view.dart';
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
  final FaheemCubit _cubit = getIt<FaheemCubit>();

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _controller.clear();
    _cubit.sendMessage(text);
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
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
    return BlocConsumer<FaheemCubit, FaheemState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is FaheemSending || state is FaheemMessageReceived) {
          _scrollToBottom();
        }
        if (state is FaheemConversationMessagesSuccess) {
          _scrollToBottom();
        }
        if (state is FaheemSendFailure) {
          if (state.errMessage.toLowerCase().contains('unauthenticated'))
            return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        // Show loading spinner while fetching history messages
        if (state is FaheemConversationMessagesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final messages = switch (state) {
          FaheemSending s => s.messages,
          FaheemMessageReceived s => s.messages,
          FaheemSendFailure s => s.messages,
          FaheemConversationMessagesSuccess s => s.messages,
          _ => _cubit.messages,
        };

        final hasMessages = messages.isNotEmpty;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: kTopPadding,
          ),
          child: Column(
            children: [
              // App bar
              FaheemChatAppBar(
                showTitle: hasMessages,
                onHistoryTap: () {
                  Navigator.pushNamed(context, FaheemHistoryView.routeName);
                },
              ),

              // Content
              Expanded(
                child: hasMessages
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
      },
    );
  }
}

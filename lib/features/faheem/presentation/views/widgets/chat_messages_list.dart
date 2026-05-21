import 'package:flutter/material.dart';
import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';
import 'package:uni/features/faheem/presentation/views/widgets/faheem_message_bubble.dart';
import 'package:uni/features/faheem/presentation/views/widgets/faheem_typing_bubble.dart';
import 'package:uni/features/faheem/presentation/views/widgets/faheem_uni_cards_row.dart';
import 'package:uni/features/faheem/presentation/views/widgets/user_message_bubble.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({
    super.key,
    required this.messages,
    required this.scrollController,
  });

  final List<ChatMessageEntity> messages;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      itemCount: messages.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, i) => _buildMessage(messages[i]),
    );
  }

  Widget _buildMessage(ChatMessageEntity message) {
    // Typing indicator
    if (message.isTyping) return const FaheemTypingBubble();

    // Uni cards row
    if (message.contentType == MessageContentType.uniCards &&
        message.uniCards != null) {
      return FaheemUniCardsRow(faheemUniCardEntities: message.uniCards!);
    }

    // Text bubbles
    if (message.sender == MessageSender.user) {
      return UserMessageBubble(text: message.text ?? '');
    }

    return FaheemMessageBubble(text: message.text ?? '');
  }
}

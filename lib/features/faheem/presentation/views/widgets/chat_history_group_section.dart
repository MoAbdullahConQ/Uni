import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/faheem/domain/entities/chat_history_entity.dart';
import 'package:uni/features/faheem/presentation/views/widgets/chat_history_card.dart';

class ChatHistoryGroupSection extends StatelessWidget {

  const ChatHistoryGroupSection({
    super.key,
    required this.label,
    required this.chatHistoryEntities,
  });

  final String label;
  final List<ChatHistoryEntity> chatHistoryEntities;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.semiBold13.copyWith(
            color: AppColors.subtitleColor.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 12),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: chatHistoryEntities.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (_, i) => ChatHistoryCard(chatHistoryEntity: chatHistoryEntities[i]),
        ),
      ],
    );
  }
}

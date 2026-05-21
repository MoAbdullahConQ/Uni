import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/faheem/domain/entities/chat_history_entity.dart';

class ChatHistoryCard extends StatelessWidget {
  const ChatHistoryCard({
    super.key,
    required this.chatHistoryEntity,
    this.onTap,
  });

  final ChatHistoryEntity chatHistoryEntity;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          children: [
            // Faheem avatar
            Container(
              width: 52,
              height: 52,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.lightSecondaryColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: SvgPicture.asset(
                  Assets.imagesFaheemRobot,

                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title + time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chatHistoryEntity.title,
                        style: TextStyles.bold14.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Text(
                        chatHistoryEntity.timeLabel,
                        style: TextStyles.regular11.copyWith(
                          color: AppColors.subtitleColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Last message
                  Text(
                    chatHistoryEntity.lastMessage,
                    textAlign: TextAlign.right,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.regular13.copyWith(
                      color: AppColors.subtitleColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

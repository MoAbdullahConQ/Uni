import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/guide/domain/entities/guide_article_entity.dart';

class GuideArticleCard extends StatelessWidget {
  const GuideArticleCard({
    super.key,
    required this.guideArticleEntity,
    this.onTap,
  });

  final GuideArticleEntity guideArticleEntity;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowBlack.withOpacity(0.05),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(
              guideArticleEntity.title,
              style: TextStyles.bold16.copyWith(
                color: AppColors.primaryColor,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),

            // Content preview
            Text(
              guideArticleEntity.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.regular13.copyWith(
                color: AppColors.subtitleColor.withOpacity(0.8),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),

            // Divider
            const Divider(height: 1, color: AppColors.borderColor),
            const SizedBox(height: 12),

            // Author row — secondary info
            Row(
              children: [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: AppColors.borderColor,
                  child: ClipOval(
                    child: Image.network(
                      guideArticleEntity.authorAvatarUrl,
                      width: 28,
                      height: 28,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Text(
                        guideArticleEntity.authorName.isNotEmpty
                            ? guideArticleEntity.authorName[0]
                            : '؟',
                        style: TextStyles.regular13.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  guideArticleEntity.authorName,
                  style: TextStyles.regular13.copyWith(
                    color: AppColors.subtitleColor,
                  ),
                ),
                const Spacer(),
                Text(
                  guideArticleEntity.publishDate,
                  style: TextStyles.regular11.copyWith(
                    color: AppColors.subtitleColor.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

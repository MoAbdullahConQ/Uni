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
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Right: image (optional)
            if (guideArticleEntity.imagePath != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  guideArticleEntity.imagePath!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
            ],
            // Left: text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Category badge
                  Text(
                    guideArticleEntity.category,
                    style: TextStyles.semiBold11.copyWith(
                      color: AppColors.subtitleColor.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Title
                  Text(
                    guideArticleEntity.title,
                    style: TextStyles.regular14.copyWith(
                      color: AppColors.primaryColor,
                      height: 1.38,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Read time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        size: 13,
                        color: AppColors.subtitleColor.withOpacity(0.7),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        guideArticleEntity.readTime,
                        style: TextStyles.regular11.copyWith(
                          color: AppColors.subtitleColor.withOpacity(0.7),
                        ),
                      ),
                    ],
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

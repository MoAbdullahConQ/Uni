import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/services/shared_preferences_singleton.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/back_button.dart';
import 'package:uni/features/guide/domain/entities/guide_article_entity.dart';

class GuideArticleDetailViewBody extends StatelessWidget {
  const GuideArticleDetailViewBody({super.key, required this.article});

  final GuideArticleEntity article;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // App bar
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalPadding,
              vertical: kTopPadding,
            ),
            child: Row(
              children: [
                const CustomBackButton(),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    'المقال',
                    style: TextStyles.bold20.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: 8,
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // Title
              Text(
                article.title,
                style: TextStyles.bold24.copyWith(
                  color: AppColors.primaryColor,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),

              // Author row
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.borderColor,
                    child: ClipOval(
                      child: Image.network(
                        article.authorAvatarUrl,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                        headers: {
                          'Authorization': 'Bearer ${Prefs.getString('token')}',
                        },
                        errorBuilder: (context, error, stackTrace) => Text(
                          article.authorName.isNotEmpty
                              ? article.authorName[0]
                              : '؟',
                          style: TextStyles.bold14.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.authorName,
                        style: TextStyles.bold14.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        article.authorBio,
                        style: TextStyles.regular13.copyWith(
                          color: AppColors.subtitleColor.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    article.publishDate,
                    style: TextStyles.regular11.copyWith(
                      color: AppColors.subtitleColor.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Divider
              const Divider(height: 1, color: AppColors.borderColor),
              const SizedBox(height: 20),

              // Content
              Text(
                article.content,
                style: TextStyles.regular14.copyWith(
                  color: AppColors.primaryColor,
                  height: 1.8,
                ),
              ),
              const SizedBox(height: 32),
            ]),
          ),
        ),
      ],
    );
  }
}

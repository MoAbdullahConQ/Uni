import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/search/presentation/views/widgets/recent_search_item.dart';
import 'package:uni/features/search/presentation/views/widgets/trending_search_chip.dart';

class SearchHomeWidget extends StatelessWidget {
  const SearchHomeWidget({
    super.key,
    required this.recentSearches,
    required this.trendingSearches,
    this.onClearAll,
    this.onSearchTap,
    this.onDeleteRecent,
  });

  final List<String> trendingSearches;
  final VoidCallback? onClearAll;
  final List<String> recentSearches;
  final void Function(String query)? onSearchTap;
  final void Function(String query)? onDeleteRecent;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          // Recent searches header
          // display recent searches section only if there are recent searches
          if (recentSearches.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'عمليات البحث الأخيرة',
                  style: TextStyles.bold18.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                GestureDetector(
                  onTap: onClearAll,
                  child: Text(
                    'مسح الكل',
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.subtitleColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Recent searches list
            ...recentSearches.map(
              (search) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: RecentSearchItem(
                  text: search,
                  onTap: () => onSearchTap?.call(search),
                  onDelete: () => onDeleteRecent?.call(search),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Trending header
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.trending_up_rounded,
                textDirection: TextDirection.ltr,
                color: AppColors.lightPrimaryColor,
                size: 20,
              ),
              const SizedBox(width: 6),
              Text(
                'الأكثر بحثاً الآن 🔥',
                style: TextStyles.bold18.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Trending chips
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: trendingSearches
                .map(
                  (t) => TrendingSearchChip(
                    text: t,
                    onTap: () => onSearchTap?.call(t),
                  ),
                )
                .toList(),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

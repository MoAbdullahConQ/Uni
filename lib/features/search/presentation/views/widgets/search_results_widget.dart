import 'package:flutter/material.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/uni_card.dart';

class SearchResultsWidget extends StatelessWidget {
  const SearchResultsWidget({
    super.key,
    required this.results,
    required this.query,
  });

  final List<UniEntity> results;
  final String query;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 16),

          // Count + sort
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                  Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'تم العثور على ',
                      style: TextStyles.semiBold13.copyWith(
                        color: AppColors.primaryColor.withOpacity(0.6),
                      ),
                    ),
                    TextSpan(
                      text: '${results.length} جامعة',
                      style: TextStyles.bold14.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
          
              Row(
                children: [
                  Text(
                    'الترتيب حسب',
                    style: TextStyles.semiBold13.copyWith(
                      color: AppColors.primaryColor.withOpacity(0.6),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 18,
                    color: AppColors.subtitleColor,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Results list
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: results.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (_, i) => UniCard(
              selectedFilterUniEntity: results[i],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

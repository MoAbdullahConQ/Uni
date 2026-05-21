import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/faheem/domain/entities/suggestion_item_entity.dart';

class SuggestionChip extends StatelessWidget {
  const SuggestionChip({super.key, required this.suggestionItemEntity});

  final SuggestionItemEntity suggestionItemEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              color: AppColors.lightSecondaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(suggestionItemEntity.icon, size: 20, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 6),
          Text(
            suggestionItemEntity.label,
            style: TextStyles.semiBold14.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}

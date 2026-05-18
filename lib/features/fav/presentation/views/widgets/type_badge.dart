import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class TypeBadge extends StatelessWidget {
  final String type;

  const TypeBadge({super.key, required this.type});

  Color _getBadgeColor() {
    switch (type) {
      case 'حكومية':
        return AppColors.secondaryColor;
      case 'خاصة':
        return AppColors.primaryColor;
      default:
        return Colors.white;
    }
  }

  Color _getTextColor() {
    switch (type) {
      case 'خاصة':
        return AppColors.secondaryColor;
      default:
        return AppColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: _getBadgeColor(),
        borderRadius: BorderRadius.circular(6),
        border: type == 'معهد عالي'
            ? Border.all(color: AppColors.primaryColor)
            : null,
      ),
      child: Text(
        type,
        style: TextStyles.bold11.copyWith(color: _getTextColor()),
      ),
    );
  }
}

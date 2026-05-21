import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class Rating extends StatelessWidget {
  final double rating;

  const Rating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          rating.toString(),
          style: TextStyles.bold13.copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(width: 4),
        const Icon(Icons.star_rounded, size: 16, color: Color(0xFFFFC107)),
      ],
    );
  }
}
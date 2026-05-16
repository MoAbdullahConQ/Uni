import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';

class GlowingActionButton extends StatelessWidget {
  const GlowingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // TODO: Trigger chat session
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        foregroundColor: AppColors.primaryColor,
        shadowColor: AppColors.secondaryShadow,
        elevation: 10,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'دردش مع فهيم',
            style: TextStyles.bold14.copyWith(
              height: 1.43,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(Assets.imagesIconStar),
        ],
      ),
    );
  }
}

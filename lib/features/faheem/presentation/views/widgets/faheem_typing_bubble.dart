import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';

class FaheemTypingBubble extends StatelessWidget {
  const FaheemTypingBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.borderColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            '...',
            style: TextStyles.bold18.copyWith(
              color: AppColors.subtitleColor,
              letterSpacing: 3,
            ),
          ),
        ),
        const SizedBox(width: 8),
        ClipOval(
          child: SvgPicture.asset(
            Assets.imagesFaheemRobot,
            width: 32,
            height: 32,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

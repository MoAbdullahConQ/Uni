import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';

class FaheemMessageBubble extends StatelessWidget {
  const FaheemMessageBubble({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Bubble
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(20),
              ),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: TextStyles.regular14.copyWith(
                color: AppColors.primaryColor,
                height: 1.6,
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Faheem avatar
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

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/back_button.dart';

class FaheemChatAppBar extends StatelessWidget {
  final VoidCallback? onHistoryTap;
  final bool showTitle; // false في welcome screen

  const FaheemChatAppBar({super.key, this.onHistoryTap, this.showTitle = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Back button
        const CustomBackButton(),
        const SizedBox(width: 8),

        // Center: title or empty
        if (showTitle)
          Row(
            children: [
              // Online indicator + avatar
              Stack(
                children: [
                  ClipOval(
                    child: SvgPicture.asset(
                      Assets.imagesFaheemRobot,
                      width: 38,
                      height: 38,
                    ),
                  ),
                  Positioned(
                    bottom: 1,
                    right: 1,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: AppColors.lightPrimaryColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'فهيم أفندي 🤖',
                    style: TextStyles.bold18.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  Text(
                    'متصل الآن',
                    style: TextStyles.regular13.copyWith(
                      color: AppColors.lightPrimaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

        const Spacer(),
        // History button
        InkWell(
          customBorder: const CircleBorder(),
          onTap: onHistoryTap,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.history, color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}

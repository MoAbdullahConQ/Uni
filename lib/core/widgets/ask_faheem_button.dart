import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/faheem/presentation/views/faheem_chat_view.dart';

class AskFaheemButton extends StatelessWidget {
  const AskFaheemButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, FaheemChatView.routeName),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.lightPrimaryColor.withOpacity(0.35),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'اسأل فهيم',
              style: TextStyles.bold14.copyWith(color: AppColors.primaryColor),
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
        ),
      ),
    );
  }
}

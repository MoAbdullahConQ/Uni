import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';

class LogoutConfirmationSheet extends StatelessWidget {
  const LogoutConfirmationSheet({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  // call this instead of showModalBottomSheet directly
  static Future<void> show(
    BuildContext context, {
    required VoidCallback onConfirm,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => LogoutConfirmationSheet(onConfirm: onConfirm),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // robot image
          SvgPicture.asset(Assets.imagesOutRobot, height: 180),
          const SizedBox(height: 24),

          // confirmation text
          Text(
            'متأكد انك عايز تسيبنا وتمشي؟!',
            textAlign: TextAlign.center,
            style: TextStyles.bold24.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 32),

          // "ايوه" — confirm logout
          SizedBox(
            width: double.infinity,
            height: 54,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.red.withOpacity(.06),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: AppColors.red.withOpacity(.08),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
                onConfirm();
              },
              child: Text(
                'أيوه',
                style: TextStyles.bold16.copyWith(color: AppColors.red),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // "لا خلاص" — cancel
          SizedBox(
            width: double.infinity,
            height: 54,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColors.secondaryColor.withOpacity(.2),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: AppColors.secondaryColor.withOpacity(.4),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                'لا خلاص',
                style: TextStyles.bold16.copyWith(
                  color: AppColors.lightPrimaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class HeaderSearchFilterBottomSheet extends StatelessWidget {
  const HeaderSearchFilterBottomSheet({super.key, this.resetOnTap});

  final void Function()? resetOnTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          customBorder: const CircleBorder(),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.lightSecondaryColor,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderColor),
            ),
            child: const Icon(Icons.close_rounded, size: 18),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Text(
            'تصفية النتائج',
            style: TextStyles.bold20.copyWith(color: AppColors.primaryColor),
          ),
        ),

        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            splashColor: AppColors.primaryColor.withOpacity(0.1),
            onTap: resetOnTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Text(
                'إعادة ضبط',
                style: TextStyles.semiBold13.copyWith(
                  color: AppColors.subtitleColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

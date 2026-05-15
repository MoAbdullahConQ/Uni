import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_fonts.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/on_boarding/presentation/on_boarding_data.dart';

class OnBoardingPageItem extends StatelessWidget {
  const OnBoardingPageItem({super.key, required this.data});

  final OnBoardingData data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          // ── Image Card ────────────────────────────────────────
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(data.image),
            ),
          ),
          const SizedBox(height: 16),
          // ── Tag ───────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalPadding,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6),
                Text(
                  data.tag,
                  style: TextStyles.semiBold13.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // ── Title ─────────────────────────────────────────────
          RichText(
            text: TextSpan(
              style: TextStyles.bold36.copyWith(
                height: 1.20,
                fontFamily: AppFonts.arabicFont,
                color: AppColors.primaryColor,
              ),
              children: [
                TextSpan(text: '${data.title}\n'),
                TextSpan(
                  text: data.titleHighlight,
                  style: TextStyles.bold36.copyWith(
                    color: AppColors.lightPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // ── Body ──────────────────────────────────────────────
          Text(
            data.body,
            style: TextStyles.regular18.copyWith(
              color: AppColors.primaryColor.withOpacity(0.7),
              height: 1.63,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

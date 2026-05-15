import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class OnBoardingBottomBar extends StatelessWidget {
  const OnBoardingBottomBar({
    super.key,
    required this.currentPage,
    required this.pagesCount,
    required this.onNext,
    required this.onSkip,
  });

  final int currentPage;
  final int pagesCount;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).padding.bottom + 50,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Skip
          TextButton(
            onPressed: onSkip,
            child: Text(
              'تخطي',
              style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
            ),
          ),

          // Dots
          DotsIndicator(
            dotsCount: pagesCount,
            position: currentPage.toDouble(),
            decorator: DotsDecorator(
              activeColor: AppColors.primaryColor,
              color: AppColors.primaryColor.withOpacity(0.2),
              size: const Size(10, 10),
              activeSize: const Size(32, 10),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),

          // Next button
          GestureDetector(
            onTap: onNext,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: ShapeDecoration(
                color: AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(33554400),
                ),
                shadows: [
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 10,
                    offset: Offset(0, 8),
                    spreadRadius: -6,
                  ),
                  BoxShadow(
                    color: AppColors.shadowColor,
                    blurRadius: 25,
                    offset: Offset(0, 20),
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'التالي',
                    textAlign: TextAlign.center,
                    style: TextStyles.bold16.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

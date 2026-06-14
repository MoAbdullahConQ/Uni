import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key, required this.onRetry, this.onBack});

  final VoidCallback onRetry;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // robot
          Image.asset(Assets.imagesRobotInternet, height: 220),
          const SizedBox(height: 32),

          // title
          Text(
            'أوبس! انقطع الاتصال',
            style: TextStyles.bold24.copyWith(color: AppColors.primaryColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // description
          Text(
            'تأكد من اتصالك بشبكة الإنترنت، وحاول مرة تانية عشان نقدر نكمل رحلتنا ونلاقي كليتك المناسبة.',
            style: TextStyles.regular14.copyWith(
              color: AppColors.subtitleColor,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),

          // button to retry
          CustomButton(
            onPressed: onRetry,
            text: 'إعادة المحاولة',
            backgroundColor: AppColors.primaryColor,
            style: TextStyles.bold16.copyWith(color: Colors.white),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 8),
              child: Icon(Icons.refresh_rounded, color: Colors.white, size: 20),
            ),
          ),

          // button to go back to previous page if onBack is not null
          if (onBack != null) ...[
            const SizedBox(height: 16),
            GestureDetector(
              onTap: onBack,
              child: Text(
                'العودة للصفحة السابقة',
                style: TextStyles.semiBold14.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';

class SearchEmptyWidget extends StatelessWidget {
  const SearchEmptyWidget({super.key, this.onClearFilters});

  final VoidCallback? onClearFilters;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Illustration
          SvgPicture.asset(
            Assets.imagesSearchEmpty,
            height: 220,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 24),

          // Title
          Text(
            'عفواً، لا توجد نتائج 😔',
            style: TextStyles.bold23.copyWith(color: AppColors.primaryColor),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),

          // Subtitle
          Text(
            'لم نعثر على جامعات تطابق بحثك. جرب تغيير الفلاتر أو توسيع نطاق البحث.',
            textAlign: TextAlign.center,
            style: TextStyles.regular16.copyWith(
              color: AppColors.subtitleColor,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 28),

          // Clear filters button
          CustomButton(
            onPressed: onClearFilters ?? () {},
            text: 'مسح كل الفلاتر',
            backgroundColor: Colors.transparent,
            style: TextStyles.bold18.copyWith(color: AppColors.primaryColor),
            borderColor: AppColors.primaryColor,
            prefixIcon: const Icon(
              Icons.refresh_rounded,
              color: AppColors.primaryColor,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

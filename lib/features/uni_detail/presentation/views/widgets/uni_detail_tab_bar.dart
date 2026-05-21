import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_fonts.dart';
import 'package:uni/core/utils/app_text_style.dart';

class UniDetailTabBar extends StatelessWidget {
  const UniDetailTabBar({super.key, required this.tabController});

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: false,
      labelStyle: TextStyles.bold16.copyWith(fontFamily: AppFonts.arabicFont),
      unselectedLabelStyle: TextStyles.semiBold14.copyWith(
        fontFamily: AppFonts.arabicFont,
      ),
      labelColor: AppColors.primaryColor,
      unselectedLabelColor: AppColors.subtitleColor,
      indicatorColor: AppColors.primaryColor,
      // indicatorWeight: 1,
      dividerColor: AppColors.borderColor,
      dividerHeight: 0,
      indicatorSize: TabBarIndicatorSize.label,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(width: 2, color: AppColors.primaryColor),
      ),
      splashFactory: NoSplash.splashFactory,
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      labelPadding: const EdgeInsets.only(bottom: 0),
      padding: const EdgeInsets.only(left: 24),
      tabs: const [
        Tab(text: 'نبذة عامة'),
        Tab(text: 'الكليات والمصاريف'),
        Tab(text: 'الخريجين'),
      ],
    );
  }
}

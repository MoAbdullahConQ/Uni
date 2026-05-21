import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/back_button.dart';
import 'package:uni/core/widgets/search_bar_field.dart';
import 'package:uni/features/faheem/presentation/views/widgets/chat_history_group_section.dart';

class FaheemHistoryViewBody extends StatelessWidget {
  const FaheemHistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kHorizontalPadding,
              vertical: kTopPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // App bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    const CustomBackButton(),
                    Text(
                      'سجل استشارات فهيم',
                      style: TextStyles.bold20.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.lightSecondaryColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: const Icon(
                        Icons.menu_rounded,
                        size: 20,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Search
                const SearchBarField(hintText: 'ابحث في المحادثات السابقة...'),
                const SizedBox(height: 24),

                // Today
                ChatHistoryGroupSection(
                  label: 'اليوم',
                  chatHistoryEntities: getDummyTodayChats(),
                ),
                const SizedBox(height: 24),

                // This week
                ChatHistoryGroupSection(
                  label: 'هذا الأسبوع',
                  chatHistoryEntities: getDummyThisWeekChats(),
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

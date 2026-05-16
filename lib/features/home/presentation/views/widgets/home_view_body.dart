import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/search_text_field.dart';
import 'package:uni/features/home/presentation/views/widgets/custom_home_app_bar.dart';
import 'package:uni/features/home/presentation/views/widgets/faheem_banner_widget.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kTopPadding,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [const CustomHomeAppBar(), SizedBox(height: 24)],
        ),
      ),
    );
  }
}

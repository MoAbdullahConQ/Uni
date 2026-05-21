import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 50,
      color: AppColors.secondaryColor.withOpacity(.7),
    );
  }
}

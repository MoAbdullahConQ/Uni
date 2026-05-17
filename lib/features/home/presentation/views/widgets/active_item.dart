import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class ActiveItem extends StatelessWidget {
  const ActiveItem({super.key, required this.text, required this.image});

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: SvgPicture.asset(image,height: 26,)),
        const SizedBox(height: 2),
        Text(
          text,
          style: TextStyles.bold11.copyWith(color: AppColors.primaryColor),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class InActiveItem extends StatelessWidget {
  const InActiveItem({super.key, required this.image, required this.text});

  final String image;

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: SvgPicture.asset(image,height: 20,)),
        const SizedBox(height: 2),
        Text(
          text,
          style: TextStyles.semiBold11.copyWith(color: AppColors.subtitleColor),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';

class RobotSection extends StatelessWidget {
  const RobotSection({
    super.key,
    required this.title,
    this.titleStyle,
    this.subTitle, required this.heightImage,
  });

  final String title;
  final TextStyle? titleStyle;
  final Text? subTitle;
  final double heightImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 200,
            decoration: BoxDecoration(
              color: AppColors.secondaryColor.withOpacity(.01),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: 70,
                  offset: const Offset(0, 20),
                  spreadRadius: 20,
                  color: AppColors.secondaryColor.withOpacity(.5),
                ),
              ],
            ),
            child: SvgPicture.asset(Assets.imagesRobot, height: heightImage),
          ),
          const SizedBox(height: 12),
          Text(title, style: titleStyle),
          const SizedBox(height: 6),

          ?subTitle,
        ],
      ),
    );
  }
}

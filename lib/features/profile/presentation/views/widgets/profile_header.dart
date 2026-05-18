import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    this.onPressed,
    required this.textHeader,
    required this.textStyle,
  });
  final void Function()? onPressed;
  final String textHeader;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.borderColor.withOpacity(.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
              color: AppColors.primaryColor,
            ),
            onPressed: onPressed,
          ),
        ),
        const Spacer(flex: 2),
        Text(textHeader, style: textStyle),
        const Spacer(flex: 3),
      ],
    );
  }
}

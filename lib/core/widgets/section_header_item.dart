import 'package:flutter/material.dart';

class SectionHeaderItem extends StatelessWidget {
  const SectionHeaderItem({
    super.key,
    required this.title,
    this.onTap,
    required this.subTitle,
    this.titleStyle,
    this.subTitleStyle,
  });

  final String title, subTitle;
  final VoidCallback? onTap;
  final TextStyle? titleStyle, subTitleStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Title
            Text(title, style: titleStyle),

            Text(subTitle, style: subTitleStyle),
          ],
        ),
      ),
    );
  }
}

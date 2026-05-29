import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class LocationRow extends StatelessWidget {
  const LocationRow({
    super.key,
    required this.location,
    required this.iconSize,
  });

  final String location;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on_outlined,
          size: iconSize,
          color: AppColors.subtitleColor.withOpacity(0.7),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: Text(
            location,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyles.regular12.copyWith(
              color: AppColors.subtitleColor.withOpacity(.7),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/location_widget.dart';
import 'package:uni/core/widgets/rating.dart';
import 'package:uni/core/widgets/type_badge_widget.dart';

class UniDetailInfoHeader extends StatelessWidget {
  final String name;
  final String type;
  final String address;
  final double rate;

  const UniDetailInfoHeader({
    super.key,
    required this.name,
    required this.type,
    required this.address,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Name + Type
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                name,
                textAlign: TextAlign.right,
                style: TextStyles.bold24.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TypeBadgeWidget(type: type),
                const SizedBox(height: 6),
                Rating(rating: rate),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),

        // location
        LocationRow(location: address, iconSize: 16),
      ],
    );
  }
}

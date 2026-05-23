import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class FeesRangeSearchFilterBottomSheet extends StatelessWidget {
  const FeesRangeSearchFilterBottomSheet({
    super.key,
    required this.feesRange,
    this.onChanged,
  });

  final RangeValues feesRange;
  final void Function(RangeValues)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'المصاريف الدراسية (سنوياً)',
              style: TextStyles.bold18.copyWith(color: AppColors.primaryColor),
            ),
            Text(
              'EGP ${(feesRange.end / 1000).toStringAsFixed(0)}k - ${(feesRange.start / 1000).toStringAsFixed(0)}k',
              style: TextStyles.semiBold13.copyWith(
                color: AppColors.primaryColor.withOpacity(.6),
              ),
            ),
          ],
        ),

        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 6,
            activeTrackColor: AppColors.secondaryColor,
            inactiveTrackColor: AppColors.borderColor,
            rangeThumbShape: const CustomRangeThumbShape(
              thumbColor: Colors.white,
              borderColor: AppColors.secondaryColor,
            ),
            overlayColor: AppColors.secondaryColor.withOpacity(0.2),
          ),
          child: RangeSlider(
            padding: const EdgeInsets.only(
              bottom: 8,
              left: 8,
              right: 8,
              top: 16,
            ),
            values: feesRange,
            min: 0,
            max: 500000,
            onChanged: onChanged,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0',
                style: TextStyles.semiBold11.copyWith(
                  color: AppColors.primaryColor.withOpacity(.6),
                ),
              ),
              Text(
                '500k+',
                style: TextStyles.semiBold11.copyWith(
                  color: AppColors.primaryColor.withOpacity(.6),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomRangeThumbShape extends RangeSliderThumbShape {
  final double thumbRadius;
  final Color thumbColor;
  final Color borderColor;

  const CustomRangeThumbShape({
    this.thumbRadius = 11,
    this.thumbColor = Colors.white,
    this.borderColor = Colors.green,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool isOnTop = false,
    bool isPressed = false,
    required SliderThemeData sliderTheme,
    TextDirection textDirection = TextDirection.ltr,
    Thumb thumb = Thumb.start,
  }) {
    final canvas = context.canvas;

    canvas.drawCircle(
      center,
      thumbRadius,
      Paint()
        ..color = thumbColor
        ..style = PaintingStyle.fill,
    );

    canvas.drawCircle(
      center,
      thumbRadius,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }
}

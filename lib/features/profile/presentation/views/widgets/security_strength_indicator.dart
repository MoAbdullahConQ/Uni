import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_text_style.dart';

class SecurityStrengthIndicator extends StatelessWidget {
  const SecurityStrengthIndicator({super.key, required this.strength});

  /// 0.0 → 1.0
  final double strength;

  String get _label {
    if (strength <= 0.25) return 'ضعيفة';
    if (strength <= 0.5) return 'متوسطة';
    if (strength <= 0.75) return 'جيدة';
    return 'قوية';
  }

  Color get _activeColor {
    if (strength <= 0.25) return Colors.red;
    if (strength <= 0.5) return Colors.orange;
    if (strength <= 0.75) return const Color(0xFF6BBF26);
    return const Color(0xFF154618);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (index) {
            final filled = (index + 1) / 4 <= strength;
            return Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(left: index < 3 ? 4 : 0),
                height: 5,
                decoration: BoxDecoration(
                  color: filled ? _activeColor : const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
        Text(
          'قوة كلمة المرور: $_label',
          style: TextStyles.regular12.copyWith(color: _activeColor),
        ),
      ],
    );
  }
}

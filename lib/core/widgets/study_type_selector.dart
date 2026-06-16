import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class PersonalDataStudyTypeSelector extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;
  final Map<String, IconData>? icons;

  const PersonalDataStudyTypeSelector({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
    this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: options.reversed
          .map(
            (option) => Expanded(
              child: GestureDetector(
                onTap: () => onSelected(option),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: selected == option
                        ? AppColors.secondaryColor
                        : const Color(0xFFF3F4F6),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected == option
                          ? AppColors.lightPrimaryColor
                          : Colors.transparent,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        if (icons != null && icons![option] != null)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: ShapeDecoration(
                              color: const Color(0x4CFFFEFE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(33554400),
                              ),
                            ),
                            child: Icon(icons![option]),
                          ),
                        SizedBox(height: icons != null ? 8 : 0),
                        Text(
                          option,
                          style:
                              (selected == option
                                      ? TextStyles.bold14
                                      : TextStyles.regular14)
                                  .copyWith(
                                    color: selected == option
                                        ? AppColors.primaryColor
                                        : AppColors.subtitleColor,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

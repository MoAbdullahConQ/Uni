import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class PersonalDataInterestsSelector extends StatefulWidget {
  const PersonalDataInterestsSelector({super.key});

  @override
  State<PersonalDataInterestsSelector> createState() =>
      _PersonalDataInterestsSelectorState();
}

class _PersonalDataInterestsSelectorState
    extends State<PersonalDataInterestsSelector> {
  final List<String> allInterests = [
    'هندسة',
    'إدارة أعمال',
    'حاسبات ومعلومات',
    'هندسة بترول',
    'علوم',
    'فنون تطبيقية',
    'إعلام',
  ];

  final Set<String> selected = {'هندسة', 'إدارة أعمال'};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.start,
      children: allInterests.map((interest) {
        final isSelected = selected.contains(interest);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selected.remove(interest);
              } else {
                selected.add(interest);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryColor
                  : const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              interest,
              style: isSelected
                  ? TextStyles.semiBold13.copyWith(color: Colors.white)
                  : TextStyles.regular14.copyWith(
                      color: AppColors.subtitleColor,
                    ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

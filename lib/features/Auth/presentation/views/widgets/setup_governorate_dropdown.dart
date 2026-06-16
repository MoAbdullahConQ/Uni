import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

// governorate id map — matches backend governorate_id values
const List<Map<String, dynamic>> kGovernorates = [
  {'id': 1, 'name': 'القاهرة'},
  {'id': 2, 'name': 'الجيزة'},
  {'id': 3, 'name': 'الإسكندرية'},
  {'id': 4, 'name': 'الدقهلية'},
  {'id': 5, 'name': 'الشرقية'},
  {'id': 6, 'name': 'المنوفية'},
  {'id': 7, 'name': 'الغربية'},
  {'id': 8, 'name': 'كفر الشيخ'},
  {'id': 9, 'name': 'دمياط'},
  {'id': 10, 'name': 'بورسعيد'},
  {'id': 11, 'name': 'الإسماعيلية'},
  {'id': 12, 'name': 'السويس'},
  {'id': 13, 'name': 'شمال سيناء'},
  {'id': 14, 'name': 'جنوب سيناء'},
  {'id': 15, 'name': 'البحيرة'},
  {'id': 16, 'name': 'مرسى مطروح'},
  {'id': 17, 'name': 'الفيوم'},
  {'id': 18, 'name': 'بني سويف'},
  {'id': 19, 'name': 'المنيا'},
  {'id': 20, 'name': 'أسيوط'},
  {'id': 21, 'name': 'سوهاج'},
  {'id': 22, 'name': 'قنا'},
  {'id': 23, 'name': 'الأقصر'},
  {'id': 24, 'name': 'أسوان'},
  {'id': 25, 'name': 'البحر الأحمر'},
  {'id': 26, 'name': 'الوادي الجديد'},
];

class SetupGovernorateDropdown extends StatelessWidget {
  const SetupGovernorateDropdown({
    super.key,
    required this.selectedId,
    required this.onChanged,
  });

  final int? selectedId;
  final ValueChanged<int?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.borderColor.withOpacity(.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          menuMaxHeight: 600,
          menuWidth: 250,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          borderRadius: BorderRadius.circular(12),
          value: selectedId,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 20),
          hint: Text(
            'اختر محافظتك',
            style: TextStyles.regular16.copyWith(
              color: AppColors.primaryColor.withOpacity(.4),
            ),
          ),
          items: kGovernorates
              .map(
                (g) => DropdownMenuItem<int>(
                  value: g['id'] as int,
                  child: Text(g['name'] as String),
                ),
              )
              .toList(),
          onChanged: onChanged,
          style: TextStyles.regular16.copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}

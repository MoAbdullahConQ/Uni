import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/section_header_item.dart';

class CampusPhotosGrid extends StatelessWidget {
  const CampusPhotosGrid({
    super.key,
    required this.photoPaths,
    required this.totalCount,
  });

  final List<String> photoPaths;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SectionHeaderItem(
          title: 'الحياة الجامعية 📸',
          titleStyle: TextStyles.bold18.copyWith(color: AppColors.primaryColor),
          subTitle: 'عرض الكل ($totalCount)',
          subTitleStyle: TextStyles.semiBold13.copyWith(
            color: AppColors.lightPrimaryColor,
          ),
        ),
        // Header
        const SizedBox(height: 12),

        // Grid
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 1.2,
          ),
          itemCount: photoPaths.length > 4 ? 4 : photoPaths.length,
          itemBuilder: (_, i) {
            final isLast = i == 3 && totalCount > 4;
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(photoPaths[i], fit: BoxFit.cover),
                  if (isLast)
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: Text(
                          '+${totalCount - 3}',
                          style: TextStyles.bold24.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

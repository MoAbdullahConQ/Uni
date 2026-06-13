import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/section_header_item.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/campus_photos_sheet.dart';

class CampusPhotosGrid extends StatelessWidget {
  const CampusPhotosGrid({
    super.key,
    required this.photoPaths,
    required this.totalCount,
  });

  final List<String> photoPaths;
  final int totalCount;

  void _showAllPhotos(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CampusPhotosSheet(photoPaths: photoPaths),
    );
  }

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
          onTap: () => _showAllPhotos(context),
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
                  Image.network(photoPaths[i], fit: BoxFit.cover),
                  if (isLast)
                    GestureDetector(
                      onTap: () => _showAllPhotos(context),
                      child: Container(
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

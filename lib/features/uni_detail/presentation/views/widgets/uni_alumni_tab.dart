import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_detail_entity.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/campus_photos_grid.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_alumni_card.dart';

class UniAlumniTab extends StatelessWidget {
  const UniAlumniTab({super.key, required this.uniDetailEntity});

  final UniDetailEntity uniDetailEntity;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Success stories
          Text(
            'قصص نجاح ⭐',
            style: TextStyles.bold18.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 12),
          ...uniDetailEntity.alumni.map((alumni) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: UniAlumniCard(uniDetailEntity: alumni),
            );
          }),
          const SizedBox(height: 10),

          // Campus photos
          CampusPhotosGrid(
            photoPaths: uniDetailEntity.campusPhotoPaths,
            totalCount: uniDetailEntity.campusPhotoPaths.length,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

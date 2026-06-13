import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/empty_state_widget.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_alumni_entity.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/campus_photos_grid.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_alumni_card.dart';

class UniAlumniTab extends StatelessWidget {
  const UniAlumniTab({
    super.key,
    required this.uniAlumniEntities,
    required this.campusPhotoPaths,
  });

  final List<UniAlumniEntity> uniAlumniEntities;
  final List<String> campusPhotoPaths;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('alumni'),
      padding: const EdgeInsets.all(16),
      children: [
        // Success stories
        Text(
          'قصص نجاح ⭐',
          style: TextStyles.bold18.copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 12),
        if (uniAlumniEntities.isEmpty)
          const EmptyStateWidget(
            message: 'لا توجد قصص نجاح متاحة حالياً',
            icon: Icons.emoji_events_outlined,
          )
        else
          ...uniAlumniEntities.map((uniAlumniEntity) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: UniAlumniCard(uniAlumniEntity: uniAlumniEntity),
            );
          }),
        const SizedBox(height: 10),

        // Campus photos
        CampusPhotosGrid(
          photoPaths: campusPhotoPaths,
          totalCount: campusPhotoPaths.length,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_detail_entity.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_stats_row.dart';

class UniOverviewTab extends StatelessWidget {
  const UniOverviewTab({super.key, required this.uniDetailEntity});

  final UniDetailEntity uniDetailEntity;

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const PageStorageKey('overview'),
      padding: const EdgeInsets.all(16),
      children: [
        // About section
        Text(
          'عن الجامعة',
          style: TextStyles.bold18.copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 10),
        Text(
          uniDetailEntity.about,
          style: TextStyles.regular14.copyWith(
            color: AppColors.subtitleColor,
            height: 1.63,
          ),
        ),
        const SizedBox(height: 22),

        // Stats
        Text(
          'أرقام وحقائق',
          style: TextStyles.bold18.copyWith(color: AppColors.primaryColor),
        ),
        const SizedBox(height: 12),
        UniStatsRow(
          studentsCount: uniDetailEntity.studentsCount,
          foundedYear: uniDetailEntity.foundedYear,
          worldRanking: uniDetailEntity.worldRanking,
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

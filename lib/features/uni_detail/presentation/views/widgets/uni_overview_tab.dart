import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_detail_entity.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_stats_row.dart';

class UniOverviewTab extends StatelessWidget {
  const UniOverviewTab({super.key, required this.uniDetailEntity});

  final UniDetailEntity uniDetailEntity;

  Future<void> _launchWebsite() async {
    final uri = Uri.parse(uniDetailEntity.website);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

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
        const SizedBox(height: 22),

        // Website
        InkWell(
          onTap: _launchWebsite,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.lightSecondaryColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.secondaryColor.withOpacity(0.4),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.open_in_new,
                  textDirection: TextDirection.ltr,
                  size: 18,
                  color: AppColors.lightPrimaryColor,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    uniDetailEntity.website,
                    textAlign: TextAlign.end,
                    style: TextStyles.semiBold14.copyWith(
                      color: AppColors.primaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(
                  Icons.language,
                  size: 20,
                  color: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}

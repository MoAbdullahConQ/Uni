import 'package:flutter/material.dart';
import 'package:uni/core/widgets/custom_divider.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/stat_item.dart';

class UniStatsRow extends StatelessWidget {
  const UniStatsRow({
    super.key,
    required this.studentsCount,
    required this.foundedYear,
    required this.worldRanking,
  });

  final int studentsCount;
  final int foundedYear;
  final String worldRanking;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        StatItem(
          icon: Icons.calendar_today_outlined,
          label: 'سنة التأسيس',
          value: foundedYear.toString(),
        ),
        const CustomDivider(),
        StatItem(
          icon: Icons.emoji_events_outlined,
          label: 'التصنيف العالمي',
          value: worldRanking,
        ),
        const CustomDivider(),
        StatItem(
          icon: Icons.people_outline_rounded,
          label: 'عدد الطلاب',
          value: '${(studentsCount / 1000).toStringAsFixed(0)},000',
        ),
      ],
    );
  }
}

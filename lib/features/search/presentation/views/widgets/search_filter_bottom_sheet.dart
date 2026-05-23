import 'package:flutter/material.dart';
import 'package:uni/features/search/presentation/views/widgets/fees_range_search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/header_search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/results_btn_search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/specialties_search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/uni_Types_search_filter_bottom_sheet.dart';

class SearchFilterBottomSheet extends StatelessWidget {
  const SearchFilterBottomSheet({super.key});

  static const List<String> specialties = [
    'هندسة',
    'أرخص كليات هندسة؟',
    'طب بشري',
    'صيدلة',
    'إدارة أعمال',
    'فنون تطبيقية',
  ];

  static const List<String> types = ['حكومية', 'خاصة', 'معاهد عليا'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          HeaderSearchFilterBottomSheet(resetOnTap: () {}),
          const SizedBox(height: 24),

          // Fees Range
          const FeesRangeSearchFilterBottomSheet(),
          const SizedBox(height: 20),

          // Specialties
          SpecialtiesSearchFilterBottomSheet(
            specialties: specialties,
            isSelected: true,
            onTap: () {},
          ),
          const SizedBox(height: 20),

          // Uni types
          UniTypesSearchFilterBottomSheet(
            isSelected: false,
            onTap: () {},
            types: types,
          ),
          const SizedBox(height: 20),

          // Apply button + expected results
          ResultsBtnSearchFilterBottomSheet(onPressed: () {}),
        ],
      ),
    );
  }
}

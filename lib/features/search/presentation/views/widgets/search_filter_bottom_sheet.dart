import 'package:flutter/material.dart';
import 'package:uni/features/search/domain/entities/search_filter_entity.dart';
import 'package:uni/features/search/presentation/views/widgets/fees_range_search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/header_search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/results_btn_search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/specialties_search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/uni_Types_search_filter_bottom_sheet.dart';

class SearchFilterBottomSheet extends StatefulWidget {
  const SearchFilterBottomSheet({
    super.key,
    required this.initialSearchFilterEntity,
  });

  final SearchFilterEntity initialSearchFilterEntity;

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
  State<SearchFilterBottomSheet> createState() =>
      _SearchFilterBottomSheetState();
}

class _SearchFilterBottomSheetState extends State<SearchFilterBottomSheet> {
  late SearchFilterEntity searchFilterEntity;
  late RangeValues feesRange;

  @override
  void initState() {
    super.initState();
    searchFilterEntity = widget.initialSearchFilterEntity;
    feesRange = RangeValues(
      searchFilterEntity.minFees,
      searchFilterEntity.maxFees,
    );
  }

  void toggleSpecialty(String specialty) {
    final list = List<String>.from(searchFilterEntity.selectedSpecialties);
    list.contains(specialty) ? list.remove(specialty) : list.add(specialty);
    setState(() {
      searchFilterEntity = searchFilterEntity.copyWith(
        selectedSpecialties: list,
      );
    });
  }

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
          HeaderSearchFilterBottomSheet(
            resetOnTap: () {
              setState(() {
                searchFilterEntity = const SearchFilterEntity();
                feesRange = const RangeValues(10000, 250000);
              });
            },
          ),
          const SizedBox(height: 24),

          // Fees Range
          FeesRangeSearchFilterBottomSheet(
            feesRange: feesRange,
            onChanged: (value) {
              setState(() {
                feesRange = value;
              });
            },
          ),
          const SizedBox(height: 20),

          // Specialties
          SpecialtiesSearchFilterBottomSheet(
            specialties: SearchFilterBottomSheet.specialties,
            isSelected: (String s) =>
                searchFilterEntity.selectedSpecialties.contains(s),
            onTap: (String s) {
              toggleSpecialty(s);
            },
          ),
          const SizedBox(height: 20),

          // Uni types
          UniTypesSearchFilterBottomSheet(
            isSelected: false,
            onTap: () {},
            types: SearchFilterBottomSheet.types,
          ),
          const SizedBox(height: 20),

          // Apply button + expected results
          ResultsBtnSearchFilterBottomSheet(onPressed: () {}),
        ],
      ),
    );
  }
}

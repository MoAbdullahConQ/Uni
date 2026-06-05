import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/features/search/domain/entities/search_filter_entity.dart';
import 'package:uni/features/search/presentation/manager/specialties_cubit/specialties_cubit.dart';
import 'package:uni/features/search/presentation/views/widgets/fees_range_search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/header_search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/results_btn_search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/specialties_search_filter_bottom_sheet.dart';
import 'package:uni/features/search/presentation/views/widgets/uni_Types_search_filter_bottom_sheet.dart';

class SearchFilterBottomSheet extends StatefulWidget {
  const SearchFilterBottomSheet({
    super.key,
    required this.initialSearchFilterEntity,
    required this.onApply,
  });

  final SearchFilterEntity initialSearchFilterEntity;
  final ValueChanged<SearchFilterEntity> onApply;

  // static const List<String> specialties = [
  //   'هندسة',
  //   'طب بشري',
  //   'صيدلة',
  //   'إدارة أعمال',
  //   'فنون تطبيقية',
  // ];

  static const List<String> types = ['حكومية', 'خاصة'];

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

    final cubit = context.read<SpecialtiesCubit>();
    if (cubit.state is SpecialtiesInitial) {
      cubit.getSpecialties();
    }
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

  void toggleType(String type) {
    final list = List<String>.from(searchFilterEntity.selectedTypes);
    list.contains(type) ? list.remove(type) : list.add(type);
    setState(() {
      searchFilterEntity = searchFilterEntity.copyWith(selectedTypes: list);
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
          // SpecialtiesSearchFilterBottomSheet(
          //   isSelected: (String s) =>
          //       searchFilterEntity.selectedSpecialties.contains(s),
          //   onTap: (String s) {
          //     toggleSpecialty(s);
          //   },
          // ),
          // const SizedBox(height: 20),

          // Specialties من الـ API
          SpecialtiesSearchFilterBottomSheet(
            isSelected: (String s) =>
                searchFilterEntity.selectedSpecialties.contains(s),
            onTap: toggleSpecialty,
          ),

          // Uni types
          UniTypesSearchFilterBottomSheet(
            isSelected: (String t) =>
                searchFilterEntity.selectedTypes.contains(t),
            onTap: (String t) {
              toggleType(t);
            },
            types: SearchFilterBottomSheet.types,
          ),
          const SizedBox(height: 20),

          // Apply button
          ResultsBtnSearchFilterBottomSheet(
            onPressed: () {
              widget.onApply(
                searchFilterEntity.copyWith(
                  minFees: feesRange.start,
                  maxFees: feesRange.end,
                ),
              );
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

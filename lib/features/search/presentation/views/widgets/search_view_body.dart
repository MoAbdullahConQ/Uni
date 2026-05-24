import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/widgets/filter_button_badge.dart';
import 'package:uni/core/widgets/search_bar_field.dart';
import 'package:uni/features/search/domain/entities/search_filter_entity.dart';
import 'package:uni/features/search/presentation/views/widgets/search_filter_bottom_sheet.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final TextEditingController controller = TextEditingController();
  SearchFilterEntity searchFilterEntity = const SearchFilterEntity();

  void showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SearchFilterBottomSheet(
          initialSearchFilterEntity: searchFilterEntity,
          onApply: (searchFilterEntity) {
            setState(() {
              this.searchFilterEntity = searchFilterEntity;
            });
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: Column(
        children: [
          // App bar
          SearchBarField(
            controller: controller,
            hintText: 'ابحث عن جامعة، كلية، أو تخصص',
            showBackButton: true,
            onChanged: (value) {},
            onClear: (){
              controller.clear();
              setState(() {});
            },
            trailing: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: FilterButtonBadge(
                activeFiltersCount: searchFilterEntity.activeFiltersCount,
                onFilterTap: showFilterSheet,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

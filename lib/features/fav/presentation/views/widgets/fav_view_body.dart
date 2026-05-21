import 'package:flutter/material.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/search_bar_field.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/widgets/uni_count_header.dart';
import 'package:uni/core/widgets/uni_filter_tab_bar.dart';
import 'package:uni/core/widgets/uni_list_widget.dart';

class FavViewBody extends StatefulWidget {
  const FavViewBody({super.key});

  @override
  State<FavViewBody> createState() => _FavViewBodyState();
}

class _FavViewBodyState extends State<FavViewBody> {
  String selectedFilter = 'الكل';

  // TODO: replace with real data from cubit
  final List<UniEntity> allFavUniEntities = const [
    UniEntity(
      name: 'الجامعة البريطانية في مصر',
      location: 'مدينة الشروق',
      imagePath: Assets.imagesUniPic,
      type: 'خاصة',
      rating: 4.8,
      averageFees: '180k EGP',
    ),
    UniEntity(
      name: 'جامعة عين شمس',
      location: 'العباسية، القاهرة',
      imagePath: Assets.imagesUniPic,
      type: 'حكومية',
      rating: 4.5,
      averageFees: '25k EGP',
    ),
    UniEntity(
      name: 'جامعة الجلالة',
      location: 'هضبة الجلالة',
      imagePath: Assets.imagesUniPic,
      type: 'معهد عالي',
      rating: 3.1,
      averageFees: '110k EGP',
    ),
    UniEntity(
      name: 'جامعة عين شمس',
      location: 'العباسية، القاهرة',
      imagePath: Assets.imagesUniPic,
      type: 'حكومية',
      rating: 4.5,
      averageFees: '25k EGP',
    ),
    UniEntity(
      name: 'جامعة الجلالة',
      location: 'هضبة الجلالة',
      imagePath: Assets.imagesUniPic,
      type: 'معهد عالي',
      rating: 3.1,
      averageFees: '110k EGP',
    ),
  ];

  List<UniEntity> get selectedFilterFavUniEntities {
    if (selectedFilter == 'الكل') return allFavUniEntities;
    return allFavUniEntities.where((e) => e.type == selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kTopPadding,
        ),
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SearchBarField(
                hintText: 'دور في المفضله',
                height: 55,
                hintStyle: TextStyles.regular16.copyWith(
                  color: AppColors.subtitleColor.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Filter tab bar
            UniFilterTabBar(
              selectedFilter: selectedFilter,
              onFilterChanged: (filter) {
                setState(() {
                  selectedFilter = filter;
                });
              },
            ),
            const SizedBox(height: 24),

            // Count + sort
            UniCountHeader(
              count: selectedFilterFavUniEntities.length,
              label: 'جامعات مفضلة',
            ),
            const SizedBox(height: 16),

            // List
            UniListWidget(
              selectedFilterUniEntities: selectedFilterFavUniEntities,
              itemCount: selectedFilterFavUniEntities.length,
              onDelete: () {},
              onTap: () {},
            ),
            // const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

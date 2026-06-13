import 'package:flutter/material.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_detail_entity.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_alumni_tab.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_detail_bottom_bar.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_detail_hero_image.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_detail_info_header.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_detail_tab_bar.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_faculties_tab.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_overview_tab.dart';

class UniDetailContent extends StatelessWidget {
  const UniDetailContent({
    super.key,
    required this.uniDetailEntity,
    required this.tabController,
  });

  final UniDetailEntity uniDetailEntity;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: NestedScrollView(
            headerSliverBuilder: (_, __) => [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    // Hero image + logo + back
                    UniDetailHeroImage(
                      imagePath: uniDetailEntity.heroImagePath,
                      logoPath: uniDetailEntity.logoImagePath,
                    ),
                    const SizedBox(height: 52),

                    // Name + type + address
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: UniDetailInfoHeader(
                        name: uniDetailEntity.name,
                        type: uniDetailEntity.type,
                        address: uniDetailEntity.address,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // Tab bar
              SliverPersistentHeader(
                pinned: true,
                delegate: _StickyTabBarDelegate(tabController: tabController),
              ),
            ],
            body: TabBarView(
              controller: tabController,
              children: [
                UniOverviewTab(uniDetailEntity: uniDetailEntity),
                UniFacultiesTab(
                  uniFacultyEntities: uniDetailEntity.uniFacultyEntities,
                ),
                UniAlumniTab(
                  uniAlumniEntities: uniDetailEntity.uniAlumniEntities,
                  campusPhotoPaths: uniDetailEntity.campusPhotoPaths,
                ),
              ],
            ),
          ),
        ),

        // Bottom action bar
        const UniDetailBottomBar(),
      ],
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabController tabController;
  const _StickyTabBarDelegate({required this.tabController});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          UniDetailTabBar(tabController: tabController),
          const Divider(height: 1),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 49;

  @override
  double get minExtent => 49;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}

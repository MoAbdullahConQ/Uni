import 'package:flutter/material.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_detail_entity.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_alumni_tab.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_detail_hero_image.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_detail_info_header.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_detail_tab_bar.dart';

class UniDetailViewBody extends StatefulWidget {
  const UniDetailViewBody({super.key});

  @override
  State<UniDetailViewBody> createState() => _UniDetailViewBodyState();
}

class _UniDetailViewBodyState extends State<UniDetailViewBody>
    with SingleTickerProviderStateMixin {
  UniDetailEntity uniDetailEntity = getDummyUniDetailEntity();

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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

                    // Tab bar
                    UniDetailTabBar(tabController: tabController),
                    const Divider(height: 1),
                  ],
                ),
              ),
            ],
            body: UniAlumniTab(uniDetailEntity: uniDetailEntity),
          ),
        ),
      ],
    );
  }
}

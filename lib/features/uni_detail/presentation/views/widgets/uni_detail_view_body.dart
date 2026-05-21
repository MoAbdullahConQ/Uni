import 'package:flutter/material.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_detail_entity.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_detail_hero_image.dart';

class UniDetailViewBody extends StatelessWidget {
  const UniDetailViewBody({super.key});

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
                      imagePath: getDummyUniDetailEntity().heroImagePath,
                      logoPath: getDummyUniDetailEntity().logoImagePath,
                    ),
                    const SizedBox(height: 52),
                  ],
                ),
              ),
            ],
            body: const Text('data'),
          ),
        ),
      ],
    );
  }
}

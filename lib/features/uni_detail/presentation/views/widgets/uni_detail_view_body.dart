import 'package:flutter/material.dart';
import 'package:uni/core/helper_functions/getDummyEntities.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_detail_hero_image.dart';
import 'package:uni/features/uni_detail/presentation/views/widgets/uni_detail_info_header.dart';

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

                    // Name + type + address
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: UniDetailInfoHeader(
                        name: getDummyUniDetailEntity().name,
                        type: getDummyUniDetailEntity().type,
                        address: getDummyUniDetailEntity().address,
                      ),
                    ),
                    const SizedBox(height: 16),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/cubits/trending_cubit/trending_cubit.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/home/presentation/views/widgets/trending_uni_card.dart';

class TrendingUnisSection extends StatelessWidget {
  const TrendingUnisSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'الجامعات التريند',
              textAlign: TextAlign.right,
              style: TextStyles.bold18.copyWith(color: AppColors.primaryColor),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.trending_up,
              textDirection: TextDirection.ltr,
              color: AppColors.secondaryColor,
            ),
          ],
        ),
        const SizedBox(height: 14),
        BlocBuilder<TrendingCubit, TrendingState>(
          builder: (context, state) {
            if (state is TrendingLoading || state is TrendingInitial) {
              return const SizedBox(
                height: 85,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 2,
                  ),
                ),
              );
            }

            if (state is TrendingFailure) {
              return SizedBox(
                height: 85,
                child: Center(
                  child: Text(
                    state.message,
                    style: TextStyles.regular14.copyWith(
                      color: AppColors.subtitleColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (state is TrendingEmpty) {
              return SizedBox(
                height: 85,
                child: Center(
                  child: Text(
                    'لا توجد جامعات تريند حالياً',
                    style: TextStyles.regular14.copyWith(
                      color: AppColors.subtitleColor,
                    ),
                  ),
                ),
              );
            }

            if (state is TrendingSuccess) {
              return SizedBox(
                height: 85,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  itemCount: state.unis.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    return TrendingUniCard(
                      trendingUniEntity: state.unis[index],
                    );
                  },
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/home/presentation/manager/recommended_cubit/recommended_cubit.dart';
import 'package:uni/features/home/presentation/views/widgets/recommended_uni_card.dart';

class RecommendedUnisSection extends StatelessWidget {
  const RecommendedUnisSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          ' ترشيحات تناسبك ✨',
          style: TextStyles.bold18.copyWith(
            color: AppColors.primaryColor,
            height: 1.56,
          ),
        ),

        const SizedBox(height: 12),

        BlocBuilder<RecommendedCubit, RecommendedState>(
          builder: (context, state) {
            if (state is RecommendedLoading || state is RecommendedInitial) {
              return const SizedBox(
                height: 270,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor,
                    strokeWidth: 2,
                  ),
                ),
              );
            }

            if (state is RecommendedFailure) {
              return SizedBox(
                height: 270,
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

            if (state is RecommendedEmpty) {
              return SizedBox(
                height: 270,
                child: Center(
                  child: Text(
                    'لا توجد ترشيحات حالياً',
                    style: TextStyles.regular14.copyWith(
                      color: AppColors.subtitleColor,
                    ),
                  ),
                ),
              );
            }

            if (state is RecommendedSuccess) {
              return SizedBox(
                height: 270,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  itemCount: state.unis.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) => RecommendedUniCard(
                    recommendedUniEntity: state.unis[index],
                  ),
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

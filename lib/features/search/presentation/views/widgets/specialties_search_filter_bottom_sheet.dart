import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/search/presentation/manager/specialties_cubit/specialties_cubit.dart';
import 'package:uni/features/search/presentation/views/widgets/filter_specialty_chip.dart';

class SpecialtiesSearchFilterBottomSheet extends StatelessWidget {
  const SpecialtiesSearchFilterBottomSheet({
    super.key,
    required this.isSelected,
    required this.onTap,
  });

  final bool Function(String) isSelected;
  final void Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpecialtiesCubit, SpecialtiesState>(
      builder: (context, state) {
        if (state is SpecialtiesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is SpecialtiesSuccess) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'التخصص',
                style: TextStyles.bold18.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: state.specialties.map((s) {
                  return FilterSpecialtyChip(
                    label: s,
                    isSelected: isSelected(s),
                    onTap: () => onTap(s),
                  );
                }).toList(),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

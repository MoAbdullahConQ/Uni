import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';
import 'package:uni/features/fav/presentation/manager/fav_cubit/fav_cubit.dart';

class UniDetailBottomBar extends StatelessWidget {
  const UniDetailBottomBar({super.key, required this.uniId});

  final int uniId;

  @override
  Widget build(BuildContext context) {
    final isFav = context.watch<FavCubit>().favIds.contains(uniId);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: Row(
        children: [
          // Favorite button
          GestureDetector(
            onTap: () {
              if (isFav) {
                context.read<FavCubit>().removeFromFav(uniId);
              } else {
                context.read<FavCubit>().addToFav(uniId);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              height: 54,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isFav ? AppColors.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryColor, width: 2),
              ),
              child: Row(
                children: [
                  Icon(
                    isFav
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_outline_rounded,
                    color: isFav
                        ? AppColors.secondaryColor
                        : AppColors.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'المفضلة',
                    style: TextStyles.bold14.copyWith(
                      color: isFav
                          ? AppColors.secondaryColor
                          : AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Apply button
          Expanded(
            child: CustomButton(
              onPressed: () {},
              text: 'قدم الآن',
              backgroundColor: AppColors.secondaryColor,
              style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

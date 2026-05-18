import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';

class FavSearchBar extends StatelessWidget {
  const FavSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
        ),
        Container(
          width: MediaQuery.of(context).size.width * .65,
          margin: const EdgeInsets.only(left: 24),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                width: 1,
                color: AppColors.primaryColor.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            shadows: [
              BoxShadow(
                color: AppColors.shadowBlack.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: SizedBox(
                width: 20,
                child: Center(
                  child: SvgPicture.asset(
                    Assets.imagesIconSearch,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
              hintText: 'دور في المفضله',
              hintStyle: TextStyles.regular16.copyWith(
                color: AppColors.subtitleColor.withOpacity(0.6),
              ),
              border: _buildBorder(),
              enabledBorder: _buildBorder(),
              focusedBorder: _buildBorder(),
              fillColor: Colors.white,
              filled: true,
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.white),
    );
  }
}

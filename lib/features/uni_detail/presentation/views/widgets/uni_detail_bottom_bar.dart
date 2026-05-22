import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/custom_button.dart';

class UniDetailBottomBar extends StatefulWidget {
  const UniDetailBottomBar({super.key});

  @override
  State<UniDetailBottomBar> createState() => _UniDetailBottomBarState();
}

class _UniDetailBottomBarState extends State<UniDetailBottomBar> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
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
            onTap: () => setState(() => isFavorite = !isFavorite),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              height: 54,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isFavorite ? AppColors.primaryColor : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryColor, width: 2),
              ),
              child: Row(
                children: [
                  Icon(
                    isFavorite
                        ? Icons.bookmark_rounded
                        : Icons.bookmark_outline_rounded,
                    color: isFavorite
                        ? AppColors.secondaryColor
                        : AppColors.primaryColor,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'المفضلة',
                    style: TextStyles.bold14.copyWith(
                      color: isFavorite
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

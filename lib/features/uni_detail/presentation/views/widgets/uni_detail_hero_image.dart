import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/widgets/back_button.dart';

class UniDetailHeroImage extends StatelessWidget {
  final String imagePath;
  final String logoPath;

  const UniDetailHeroImage({
    super.key,
    required this.imagePath,
    required this.logoPath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Hero image
        SizedBox(
          height: 260,
          width: double.infinity,
          child: Image.network(imagePath, fit: BoxFit.cover),
        ),

        // Back button
        Container(
          margin: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: AppColors.borderColor,
            shape: BoxShape.circle,
          ),
          child: const CustomBackButton(),
        ),

        // Logo
        Positioned(
          bottom: -40,
          right: 24,
          child: Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(logoPath, fit: BoxFit.contain),
            ),
          ),
        ),
      ],
    );
  }
}

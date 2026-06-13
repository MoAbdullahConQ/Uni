import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_alumni_entity.dart';

class UniAlumniCard extends StatelessWidget {
  const UniAlumniCard({super.key, required this.uniAlumniEntity});

  final UniAlumniEntity uniAlumniEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipOval(
                child: Image.network(
                  uniAlumniEntity.imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.lightSecondaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.secondaryColor.withOpacity(0.4),
                  ),
                ),
                child: Text(
                  uniAlumniEntity.graduationYear,
                  style: TextStyles.semiBold11.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 10),

          // Name
          Expanded(
            child: Text(
              uniAlumniEntity.name,
              style: TextStyles.bold16.copyWith(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}

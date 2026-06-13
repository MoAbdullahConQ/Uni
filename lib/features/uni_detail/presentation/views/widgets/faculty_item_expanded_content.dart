import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/uni_detail/domain/entities/uni_faculty_entity.dart';

class FacultyItemExpandedContent extends StatelessWidget {
  const FacultyItemExpandedContent({super.key, required this.uniFacultyEntity});

  final UniFacultyEntity uniFacultyEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Fees + min grade
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Fees
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'المصاريف السنوية',
                    style: TextStyles.regular12.copyWith(
                      color: AppColors.subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    uniFacultyEntity.minFees,
                    style: TextStyles.bold18.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),

              // Min grade badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Column(
                  children: [
                    Text(
                      'الحد الأدنى',
                      style: TextStyles.regular11.copyWith(
                        color: AppColors.subtitleColor,
                      ),
                    ),
                    Text(
                      '${uniFacultyEntity.minGrade.toInt()}%',
                      style: TextStyles.bold16.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Requirements
          Text(
            'متطلبات القبول:',
            style: TextStyles.bold14.copyWith(color: AppColors.primaryColor),
          ),
          const SizedBox(height: 10),
          ...uniFacultyEntity.requirements.map(
            (req) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: Icon(
                      Icons.check_circle_rounded,
                      size: 16,
                      color: Color(0xFF6BBF26),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      req,
                      textAlign: TextAlign.right,
                      style: TextStyles.regular13.copyWith(
                        color: AppColors.subtitleColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),

          // More details
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'مزيد من التفاصيل',
                style: TextStyles.semiBold14.copyWith(
                  color: AppColors.lightPrimaryColor,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward,
                size: 18,
                color: AppColors.lightPrimaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

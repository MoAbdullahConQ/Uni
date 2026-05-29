import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/widgets/uni_card_image.dart';
import 'package:uni/core/widgets/uni_card_info.dart';

class UniCard extends StatelessWidget {
  const UniCard({
    super.key,
    required this.selectedFilterUniEntity,
    this.onDelete,
    this.onTap,
  });

  final UniEntity selectedFilterUniEntity;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      overlayColor: WidgetStatePropertyAll(
        AppColors.secondaryColor.withOpacity(0.2),
      ),
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: const Color(0xFFF3F4F6)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowBlack.withOpacity(0.06),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Right side: image + heart ──
            UniCardImage(
              imagePath: selectedFilterUniEntity.imagePath,
              isFav: selectedFilterUniEntity.isFav,
              onFavTap: () {},
            ),

            const SizedBox(width: 12),

            // ── Left side: info ──
            UniCardInfo(
              selectedFilterUniEntity: selectedFilterUniEntity,
              onDelete: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

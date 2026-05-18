import 'package:flutter/material.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/features/fav/domain/entities/fav_uni_entity.dart';
import 'package:uni/features/fav/presentation/views/widgets/fav_uni_card_image.dart';
import 'package:uni/features/fav/presentation/views/widgets/fav_uni_card_info.dart';

class FavUniCard extends StatelessWidget {
  final FavUniEntity selectedFilterFavUniEntity;
  final VoidCallback? onDelete;

  const FavUniCard({
    super.key,
    required this.selectedFilterFavUniEntity,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          FavUniCardImage(imagePath: selectedFilterFavUniEntity.imagePath),

          const SizedBox(width: 12),

          // ── Left side: info ──
          FavUniCardInfo(
            selectedFilterFavUniEntity: selectedFilterFavUniEntity,
            onDelete: onDelete,
          ),
        ],
      ),
    );
  }
}

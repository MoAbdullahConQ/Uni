import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UniCardImage extends StatelessWidget {
  const UniCardImage({
    super.key,
    required this.imagePath,
    required this.isFav,
    this.onFavTap,
  });

  final String imagePath;
  final bool isFav;
  final VoidCallback? onFavTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: imagePath,
            width: 120,
            height: 120,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.grey[200]),
            errorWidget: (context, url, error) =>
                const Icon(Icons.broken_image),
          ),
        ),
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: onFavTap,
            behavior: HitTestBehavior.opaque,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                size: 16,
                color: isFav ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

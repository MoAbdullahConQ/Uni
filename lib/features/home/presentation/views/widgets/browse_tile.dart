import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/browse/presentation/views/browse_view.dart';

class BrowseTile extends StatelessWidget {
  final VoidCallback? onTap;

  const BrowseTile({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: Color(0x66AFEC70), width: 1.6),
      ),
      leading: SvgPicture.asset(Assets.imagesExplore),
      
      title: Text(
        'تصفح الجامعات',
        style: TextStyles.bold14.copyWith(color: AppColors.primaryColor),
      ),

      subtitle: Text(
        'تصفح الجامعات المصرية سواء كانت خاصة حكومية او معاهد عليا',
        style: TextStyles.semiBold11.copyWith(
          color: AppColors.subtitleColor.withOpacity(0.9),
          height: 1.5,
        ),
      ),

      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20,
        color: AppColors.subtitleColor,
      ),

      onTap: () {
        Navigator.pushNamed(context, BrowseView.routeName);
      },
    );
  }
}

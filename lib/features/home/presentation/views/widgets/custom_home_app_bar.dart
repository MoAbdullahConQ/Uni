import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 50,
        height: 50,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.6, color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: ClipOval(child: Image.asset(Assets.imagesPageViewItem1Image)),
      ),
      title: Text(
        'اهلا بيك يا 👋',
        textAlign: TextAlign.right,
        style: TextStyles.regular12.copyWith(color: Color(0xFF697282)),
      ),
      subtitle: Text(
        'محمد مجدي عبدالغني',
        textAlign: TextAlign.right,
        style: TextStyles.bold18.copyWith(color: AppColors.primaryColor),
      ),
      trailing: Container(
        padding: const EdgeInsets.all(12),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1.6, color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: SvgPicture.asset(Assets.imagesNotification),
      ),
    );
  }
}

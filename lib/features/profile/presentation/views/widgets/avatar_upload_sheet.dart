import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

/// Bottom sheet that lets the user pick an avatar source (camera/gallery).
class AvatarUploadSheet {

  static Future<ImageSource?> show(BuildContext context) {
    return showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('تغيير الصورة الشخصية', style: TextStyles.bold16),
                const SizedBox(height: 16),
                _SheetOption(
                  icon: Icons.camera_alt_outlined,
                  label: 'التقاط صورة',
                  onTap: () =>
                      Navigator.pop(sheetContext, ImageSource.camera),
                ),
                const SizedBox(height: 8),
                _SheetOption(
                  icon: Icons.photo_library_outlined,
                  label: 'اختيار من المعرض',
                  onTap: () =>
                      Navigator.pop(sheetContext, ImageSource.gallery),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SheetOption extends StatelessWidget {
  const _SheetOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF9FAFA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE6E9E9)),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.primaryColor, size: 22),
              const SizedBox(width: 12),
              Text(label, style: TextStyles.regular14),
            ],
          ),
        ),
      ),
    );
  }
}

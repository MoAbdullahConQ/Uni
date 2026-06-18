import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';

class PersonalDataDocumentUploadCard extends StatefulWidget {
  const PersonalDataDocumentUploadCard({super.key, required this.label});

  final String label;

  @override
  State<PersonalDataDocumentUploadCard> createState() =>
      _PersonalDataDocumentUploadCardState();
}

class _PersonalDataDocumentUploadCardState
    extends State<PersonalDataDocumentUploadCard> {
  File? _pickedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );
    if (picked != null) {
      setState(() => _pickedImage = File(picked.path));
    }
  }

  void _clearImage() => setState(() => _pickedImage = null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickedImage == null ? _pickImage : null,
      child: Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFA),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _pickedImage != null
                ? AppColors.secondaryColor
                : const Color(0xFFE6E9E9),
          ),
        ),
        child: _pickedImage == null ? _buildEmptyState() : _buildPreview(),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.cloud_upload_outlined,
          size: 28,
          color: Colors.grey.shade400,
        ),
        const SizedBox(height: 6),
        Text(
          widget.label,
          style: TextStyles.regular14.copyWith(color: Colors.grey.shade400),
        ),
      ],
    );
  }

  Widget _buildPreview() {
    return Stack(
      children: [
        // image preview clipped to card shape
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.file(
            _pickedImage!,
            width: double.infinity,
            height: 120,
            fit: BoxFit.cover,
          ),
        ),
        // top-right clear button
        Positioned(
          top: 6,
          right: 6,
          child: GestureDetector(
            onTap: _clearImage,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, size: 16, color: Colors.red),
            ),
          ),
        ),
        // bottom label overlay
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(.6),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.label,
                  style: TextStyles.regular12.copyWith(color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                const Icon(Icons.check_circle, size: 14, color: Colors.white),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

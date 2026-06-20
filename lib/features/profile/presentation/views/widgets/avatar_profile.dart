import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:uni/features/profile/presentation/views/widgets/avatar_upload_sheet.dart';

class AvatarProfile extends StatefulWidget {
  const AvatarProfile({super.key});

  @override
  State<AvatarProfile> createState() => _AvatarProfileState();
}

class _AvatarProfileState extends State<AvatarProfile> {
  File? _localImage;
  bool _isUploading = false;
  // guards the gap between opening the sheet/picker and pickImage()
  // resolving — without it, a fast double-tap throws a PlatformException
  // (already_active) because image_picker doesn't allow concurrent calls.
  bool _isPicking = false;

  Future<void> _onTap() async {
    if (_isUploading || _isPicking) return;
    _isPicking = true;

    try {
      final source = await AvatarUploadSheet.show(context);
      if (source == null) return;

      final picker = ImagePicker();
      final picked = await picker.pickImage(source: source, imageQuality: 85);
      if (picked == null) return;

      final newImage = File(picked.path);
      setState(() {
        _localImage = newImage;
        _isUploading = true;
      });

      // getMe() inside ProfileCubit.uploadAvatar() refreshes currentUser with
      // the new server avatar URL, so once it's done we drop the local file
      // and let the network image take over (single source of truth).
      final success = await getIt<ProfileCubit>().uploadAvatar(newImage);

      if (!mounted) return;
      setState(() {
        _isUploading = false;
        _localImage = null;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('تم تغيير الصورة الشخصية')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('فشل تغيير الصورة، حاول مرة أخرى')),
        );
      }
    } finally {
      _isPicking = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: getIt<ProfileCubit>(),
      buildWhen: (previous, current) =>
          current is ProfileSuccess || current is ProfileLoading,
      builder: (context, state) {
        final avatarUrl = getIt<ProfileCubit>().currentUser?.avatar;

        return GestureDetector(
          onTap: _onTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 112,
                height: 112,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD1D5DB),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Opacity(
                    opacity: _isUploading ? 0.5 : 1,
                    child: _buildImage(avatarUrl),
                  ),
                ),
              ),
              if (_isUploading)
                const Positioned.fill(
                  child: Center(
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    size: 18,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImage(String? avatarUrl) {
    // local pick takes priority only while uploading is in progress —
    // cleared right after uploadAvatar() resolves (success or failure),
    // so the network image (or fallback icon) becomes the source of truth.
    if (_localImage != null) {
      return Image.file(_localImage!, fit: BoxFit.cover);
    }
    if (avatarUrl != null) {
      return Image.network(
        avatarUrl,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.person, size: 56, color: Colors.white),
      );
    }
    return const Icon(Icons.person, size: 56, color: Colors.white);
  }
}

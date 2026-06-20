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

  Future<void> _onTap() async {
    if (_isUploading) return;

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

    final success = await _uploadAvatar(newImage);

    if (!mounted) return;
    setState(() => _isUploading = false);

    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('تم تغيير الصورة الشخصية')));
    } else {
      // revert to previous (server) avatar on failure
      setState(() => _localImage = null);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('فشل تغيير الصورة، حاول مرة أخرى')),
      );
    }
  }

  // TODO: replace with real upload call once sayed adds the avatar field
  // to POST /student_info (or a dedicated endpoint). Should call
  // getIt<ProfileCubit>() so the new avatar reflects across the app
  // (Home AppBar, etc.) once the server confirms the upload.
  Future<bool> _uploadAvatar(File image) async {
    await Future.delayed(const Duration(seconds: 1));
    return false;
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
    // local pick takes priority (covers both the uploading state and a
    // successful upload, until the next getMe() refresh replaces it)
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

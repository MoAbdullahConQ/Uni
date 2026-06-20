import 'package:flutter/material.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/profile/presentation/manager/profile_cubit/profile_cubit.dart';

class UserMessageBubble extends StatelessWidget {
  final String text;

  const UserMessageBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final avatarUrl = getIt<ProfileCubit>().currentUser?.avatar;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // User avatar
        ClipOval(
          child: SizedBox(
            width: 32,
            height: 32,
            child: avatarUrl != null
                ? Image.network(
                    avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Image.asset(Assets.imagesPageViewItem1Image),
                  )
                : Image.asset(Assets.imagesPageViewItem1Image),
          ),
        ),
        const SizedBox(width: 8),
        // Bubble
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.secondaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(4),
              ),
            ),
            child: Text(
              text,
              textAlign: TextAlign.right,
              style: TextStyles.regular14.copyWith(
                color: AppColors.primaryColor,
                height: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

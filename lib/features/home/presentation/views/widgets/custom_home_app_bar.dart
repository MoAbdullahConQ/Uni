import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_images.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/notifications/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:uni/features/notifications/presentation/views/notifications_view.dart';

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
            side: const BorderSide(width: 1.6, color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: ClipOval(child: Image.asset(Assets.imagesPageViewItem1Image)),
      ),
      title: Text(
        'اهلا بيك يا 👋',
        textAlign: TextAlign.right,
        style: TextStyles.regular12.copyWith(color: AppColors.subtitleColor),
      ),
      subtitle: Text(
        'محمد مجدي عبدالغني',
        textAlign: TextAlign.right,
        style: TextStyles.bold18.copyWith(color: AppColors.primaryColor),
      ),
      trailing: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          final unreadCount = state is NotificationsSuccess
              ? state.unreadCount
              : 0;
          return InkWell(
            customBorder: const CircleBorder(),
            onTap: () {
              Navigator.pushNamed(context, NotificationsView.routeName);
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1.6, color: Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: SvgPicture.asset(Assets.imagesNotification),
                ),
                if (unreadCount > 0)
                  Positioned(
                    top: -4,
                    left: -4,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: const BoxDecoration(
                        color: AppColors.lightPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          unreadCount > 99 ? '99+' : '$unreadCount',
                          style: TextStyles.bold11.copyWith(
                            color: Colors.white,
                            fontSize: 9,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

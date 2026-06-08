import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/widgets/custom_error_widget.dart';
import 'package:uni/features/notifications/presentation/manager/notifications_cubit/notifications_cubit.dart';
import 'package:uni/features/notifications/presentation/views/widgets/notification_group_section.dart';
import 'package:uni/features/notifications/presentation/views/widgets/notifications_app_bar.dart';

class NotificationsViewBody extends StatefulWidget {
  const NotificationsViewBody({super.key});

  @override
  State<NotificationsViewBody> createState() => _NotificationsViewBodyState();
}

class _NotificationsViewBodyState extends State<NotificationsViewBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // when it reaches the last 200px — load more
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<NotificationsCubit>().loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: kTopPadding,
      ),
      child: Column(
        children: [
          const NotificationsAppBar(),
          const SizedBox(height: 24),
          Expanded(
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                if (state is NotificationsFailure) {
                  return CustomErrorWidget(message: state.errMessage);
                }

                if (state is NotificationsLoading ||
                    state is NotificationsInitial) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is NotificationsSuccess) {
                  return SingleChildScrollView(
                    controller: _scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (state.today.isNotEmpty) ...[
                          NotificationGroupSection(
                            label: 'اليوم',
                            notifications: state.today,
                          ),
                          const SizedBox(height: 24),
                        ],
                        if (state.yesterday.isNotEmpty) ...[
                          NotificationGroupSection(
                            label: 'الأمس',
                            notifications: state.yesterday,
                          ),
                          const SizedBox(height: 24),
                        ],
                        if (state.thisWeek.isNotEmpty) ...[
                          NotificationGroupSection(
                            label: 'هذا الأسبوع',
                            notifications: state.thisWeek,
                          ),
                          const SizedBox(height: 24),
                        ],
                        if (state.older.isNotEmpty) ...[
                          NotificationGroupSection(
                            label: 'أقدم',
                            notifications: state.older,
                          ),
                          const SizedBox(height: 24),
                        ],

                        // loading indicator at the bottom
                        if (state.isLoadingMore)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Center(child: CircularProgressIndicator()),
                          ),
                      ],
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}

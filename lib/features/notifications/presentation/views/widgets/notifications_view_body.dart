import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/widgets/custom_error_widget.dart';
import 'package:uni/features/notifications/domain/entities/notification_entity.dart';
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
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<NotificationsCubit>().loadMore();
    }
  }

  Widget _buildList({
    required List<NotificationEntity> today,
    required List<NotificationEntity> yesterday,
    required List<NotificationEntity> thisWeek,
    required List<NotificationEntity> older,
    bool showPaginationLoading = false,
    String? paginationError,
  }) {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (today.isNotEmpty) ...[
            NotificationGroupSection(label: 'اليوم', notifications: today),
            const SizedBox(height: 24),
          ],
          if (yesterday.isNotEmpty) ...[
            NotificationGroupSection(label: 'الأمس', notifications: yesterday),
            const SizedBox(height: 24),
          ],
          if (thisWeek.isNotEmpty) ...[
            NotificationGroupSection(
              label: 'هذا الأسبوع',
              notifications: thisWeek,
            ),
            const SizedBox(height: 24),
          ],
          if (older.isNotEmpty) ...[
            NotificationGroupSection(label: 'أقدم', notifications: older),
            const SizedBox(height: 24),
          ],
          if (showPaginationLoading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            ),
          if (paginationError != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(
                  paginationError,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            ),
        ],
      ),
    );
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
                  return _buildList(
                    today: state.today,
                    yesterday: state.yesterday,
                    thisWeek: state.thisWeek,
                    older: state.older,
                  );
                }

                if (state is NotificationsPaginationLoading) {
                  return _buildList(
                    today: state.today,
                    yesterday: state.yesterday,
                    thisWeek: state.thisWeek,
                    older: state.older,
                    showPaginationLoading: true,
                  );
                }

                if (state is NotificationsPaginationFailure) {
                  return _buildList(
                    today: state.today,
                    yesterday: state.yesterday,
                    thisWeek: state.thisWeek,
                    older: state.older,
                    paginationError: state.errMessage,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/services/get_it_service.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/back_button.dart';
import 'package:uni/core/widgets/custom_error_widget.dart';
import 'package:uni/core/widgets/search_bar_field.dart';
import 'package:uni/features/faheem/domain/entities/conversation_entity.dart';
import 'package:uni/features/faheem/presentation/manager/faheem_cubit/faheem_cubit.dart';
import 'package:uni/features/faheem/presentation/manager/faheem_cubit/faheem_state.dart';
import 'package:uni/features/faheem/presentation/views/faheem_chat_view.dart';
import 'package:uni/features/faheem/presentation/views/widgets/chat_history_group_section.dart';

class FaheemHistoryViewBody extends StatefulWidget {
  const FaheemHistoryViewBody({super.key});

  @override
  State<FaheemHistoryViewBody> createState() => _FaheemHistoryViewBodyState();
}

class _FaheemHistoryViewBodyState extends State<FaheemHistoryViewBody> {
  final FaheemCubit _cubit = getIt<FaheemCubit>();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _cubit.loadConversations();
  }

  List<ConversationEntity> _filtered(List<ConversationEntity> all) {
    if (_searchQuery.isEmpty) return all;
    return all
        .where(
          (c) => c.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

  // Group conversations into: today / this week / older
  Map<String, List<ConversationEntity>> _group(List<ConversationEntity> all) {
    final now = DateTime.now();
    final today = <ConversationEntity>[];
    final thisWeek = <ConversationEntity>[];
    final older = <ConversationEntity>[];

    for (final c in all) {
      final diff = now.difference(c.createdAt).inDays;
      if (diff == 0) {
        today.add(c);
      } else if (diff < 7) {
        thisWeek.add(c);
      } else {
        older.add(c);
      }
    }
    return {'اليوم': today, 'هذا الأسبوع': thisWeek, 'أقدم': older};
  }

  void _openConversation(ConversationEntity conversation) {
    _cubit.loadConversationMessages(conversation.id);
    Navigator.pushNamed(context, FaheemChatView.routeName);
  }

  void _startNewConversation() {
    _cubit.startNewConversation();
    Navigator.pushNamed(context, FaheemChatView.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FaheemCubit, FaheemState>(
      bloc: _cubit,
      listener: (context, state) {
        if (state is FaheemConversationsFailure) {
          if (state.errMessage.toLowerCase().contains('unauthenticated'))
            return;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: kHorizontalPadding,
                  vertical: kTopPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // App bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomBackButton(),
                        Text(
                          'سجل استشارات فهيم',
                          style: TextStyles.bold20.copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.lightSecondaryColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.borderColor),
                          ),
                          child: const Icon(
                            Icons.menu_rounded,
                            size: 20,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Search
                    SearchBarField(
                      hintText: 'ابحث في المحادثات السابقة...',
                      onChanged: (q) => setState(() => _searchQuery = q),
                    ),
                    const SizedBox(height: 24),

                    // Content
                    if (state is FaheemConversationsLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (state is FaheemConversationsFailure)
                      CustomErrorWidget(
                        message: state.errMessage,
                        onRetry: _cubit.loadConversations,
                      )
                    else if (state is FaheemConversationsSuccess) ...[
                      ..._group(_filtered(state.conversations)).entries
                          .where((e) => e.value.isNotEmpty)
                          .map(
                            (e) => Column(
                              children: [
                                ChatHistoryGroupSection(
                                  label: e.key,
                                  conversations: e.value,
                                  onTap: _openConversation,
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                    ],

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),

            // FAB — new conversation
            Positioned(
              bottom: 24,
              left: 16,
              child: GestureDetector(
                onTap: _startNewConversation,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.add_comment_outlined,
                    color: AppColors.secondaryColor,
                    size: 24,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

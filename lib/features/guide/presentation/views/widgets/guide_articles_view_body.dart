import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/widgets/back_button.dart';
import 'package:uni/core/widgets/custom_error_widget.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/features/guide/domain/entities/guide_article_entity.dart';
import 'package:uni/features/guide/presentation/manager/guide_cubit/guide_cubit.dart';
import 'package:uni/features/guide/presentation/views/guide_article_detail_view.dart';
import 'package:uni/features/guide/presentation/views/widgets/guide_article_card.dart';

class GuideArticlesViewBody extends StatefulWidget {
  const GuideArticlesViewBody({super.key});

  @override
  State<GuideArticlesViewBody> createState() => _GuideArticlesViewBodyState();
}

class _GuideArticlesViewBodyState extends State<GuideArticlesViewBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted) return;
    final max = _scrollController.position.maxScrollExtent;
    final current = _scrollController.position.pixels;
    if (current >= max * 0.8) {
      context.read<GuideCubit>().loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
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
          // App bar
          Row(
            children: [
              const CustomBackButton(),
              const SizedBox(width: 16),
              Text(
                'المقالات 📝',
                style: TextStyles.bold20.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Content
          Expanded(
            child: BlocBuilder<GuideCubit, GuideState>(
              builder: (context, state) {
                if (state is GuideFailure) {
                  return CustomErrorWidget(message: state.errMessage);
                }

                List<GuideArticleEntity> currentArticles = [];
                bool isPaginationLoading = false;
                String? paginationError;

                if (state is GuideSuccess) {
                  currentArticles = state.articles;
                } else if (state is GuidePaginationLoading) {
                  currentArticles = state.currentArticles;
                  isPaginationLoading = true;
                } else if (state is GuidePaginationFailure) {
                  currentArticles = state.currentArticles;
                  paginationError = state.errMessage;
                } else {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        controller: _scrollController,
                        itemCount: currentArticles.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (_, i) => GuideArticleCard(
                          guideArticleEntity: currentArticles[i],
                          onTap: () => Navigator.pushNamed(
                            context,
                            GuideArticleDetailView.routeName,
                            arguments: currentArticles[i],
                          ),
                        ),
                      ),
                    ),

                    if (isPaginationLoading)
                      const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(child: CircularProgressIndicator()),
                      ),

                    if (paginationError != null)
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: CustomErrorWidget(message: paginationError),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

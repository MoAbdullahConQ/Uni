import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/constants.dart';
import 'package:uni/core/utils/app_colors.dart';
import 'package:uni/core/utils/app_text_style.dart';
import 'package:uni/core/widgets/search_bar_field.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/widgets/uni_filter_tab_bar.dart';
import 'package:uni/features/fav/presentation/manager/fav_cubit/fav_cubit.dart';
import 'package:uni/features/fav/presentation/views/widgets/fav_header_and_list_bloc_consumer.dart';

class FavViewBody extends StatefulWidget {
  const FavViewBody({super.key});

  @override
  State<FavViewBody> createState() => _FavViewBodyState();
}

class _FavViewBodyState extends State<FavViewBody> {
  String selectedFilter = 'الكل';
  final ScrollController _scrollController = ScrollController();

  List<UniEntity> getFilteredEntitiesList(List<UniEntity> unis) {
    if (selectedFilter == 'الكل') return unis;
    return unis.where((e) => e.type == selectedFilter).toList();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<FavCubit>().getFavs();
  }

  void _onScroll() {
    if (!mounted) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll * 0.8) {
      final state = context.read<FavCubit>().state;
      if (state is! FavPaginationLoading) {
        context.read<FavCubit>().loadMore();
      }
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
    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kHorizontalPadding,
          vertical: kTopPadding,
        ),
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SearchBarField(
                hintText: 'دور في المفضله',
                height: 55,
                hintStyle: TextStyles.regular16.copyWith(
                  color: AppColors.subtitleColor.withOpacity(0.6),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Filter tab bar
            UniFilterTabBar(
              selectedFilter: selectedFilter,
              onFilterChanged: (filter) {
                setState(() {
                  selectedFilter = filter;
                });
              },
            ),
            const SizedBox(height: 24),

            // BlocBuilder
            FavHeaderAndListBlocConsumer(
              getFilteredEntitiesList: getFilteredEntitiesList,
            ),
            // const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/core/widgets/custom_error_widget.dart';
import 'package:uni/core/widgets/uni_count_header.dart';
import 'package:uni/core/widgets/uni_list_widget.dart';
import 'package:uni/features/search/presentation/manager/search_cubit/search_cubit.dart';

class SearchResultsBlocBuilder extends StatefulWidget {
  final String query;

  const SearchResultsBlocBuilder({super.key, required this.query});

  @override
  State<SearchResultsBlocBuilder> createState() =>
      _SearchResultsBlocBuilderState();
}

class _SearchResultsBlocBuilderState extends State<SearchResultsBlocBuilder> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted) return;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll >= maxScroll * 0.8) {
      context.read<SearchCubit>().loadMore();
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
    return BlocBuilder<SearchCubit, SearchCubitState>(
      builder: (context, state) {
        if (state is SearchFailure) {
          return CustomErrorWidget(message: state.errMessage);
        }

        List<UniEntity> currentUnis = [];
        bool isPaginationLoading = false;
        String? paginationError;

        if (state is SearchSuccess) {
          currentUnis = state.uniEntities;
        } else if (state is SearchPaginationLoading) {
          currentUnis = state.currentUnis;
          isPaginationLoading = true;
        } else if (state is SearchPaginationFailure) {
          currentUnis = state.currentUnis;
          paginationError = state.errMessage;
        } else {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            const SizedBox(height: 16),

            UniCountHeader(count: currentUnis.length, label: 'جامعة مطابقة'),
            const SizedBox(height: 12),

            Expanded(
              child: UniListWidget(
                selectedFilterUniEntities: currentUnis,
                itemCount: currentUnis.length,
                scrollController: _scrollController,
              ),
            ),

            if (isPaginationLoading)
              const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),

            if (paginationError != null)
              Padding(
                padding: const EdgeInsets.all(8),
                child: CustomErrorWidget(message: paginationError),
              ),
          ],
        );
      },
    );
  }
}

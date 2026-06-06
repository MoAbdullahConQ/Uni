import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/features/search/domain/entities/search_filter_entity.dart';
import 'package:uni/features/search/domain/use_cases/search_unis_use_case.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  final SearchUnisUseCase searchUnisUseCase;

  SearchCubit(this.searchUnisUseCase) : super(SearchInitial());

  final List<UniEntity> _allResults = [];
  String? _nextCursor;
  bool _isLoadingMore = false;
  String _lastQuery = '';
  SearchFilterEntity _lastFilter = const SearchFilterEntity();

  // Debounce timer
  // DateTime? _lastSearchTime;

  Future<void> search({
    required String query,
    SearchFilterEntity? filter,
  }) async {
    _lastQuery = query;
    _lastFilter = filter ?? const SearchFilterEntity();
    _allResults.clear();
    _nextCursor = null;
    _isLoadingMore = false;

    if (query.isEmpty && (_lastFilter.activeFiltersCount == 0)) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    final result = await searchUnisUseCase.call(
      query: query,
      filter: _lastFilter,
    );

    result.fold((failure) => emit(SearchFailure(failure.message)), (response) {
      _allResults.addAll(response.uniEntities);
      _nextCursor = response.nextCursor;
      if (_allResults.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(
          SearchSuccess(
            uniEntities: List.from(_allResults),
            nextCursor: _nextCursor,
          ),
        );
      }
    });
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || _nextCursor == null) return;

    _isLoadingMore = true;
    emit(SearchPaginationLoading(List.from(_allResults)));

    final result = await searchUnisUseCase.call(
      query: _lastQuery,
      filter: _lastFilter,
      cursor: _nextCursor,
    );

    result.fold(
      (failure) {
        _isLoadingMore = false;
        emit(
          SearchPaginationFailure(
            errMessage: failure.message,
            currentUnis: List.from(_allResults),
          ),
        );
      },
      (response) {
        _allResults.addAll(response.uniEntities);
        _nextCursor = response.nextCursor;
        _isLoadingMore = false;
        emit(
          SearchSuccess(
            uniEntities: List.from(_allResults),
            nextCursor: _nextCursor,
          ),
        );
      },
    );
  }
}

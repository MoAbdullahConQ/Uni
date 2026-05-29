import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/features/browse/domain/use_cases/get_unis_use_case.dart';

part 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  final GetUnisUseCase getUnisUseCase;

  BrowseCubit(this.getUnisUseCase) : super(BrowseInitial());

  final List<UniEntity> _allUnis = [];
  String? _nextCursor;
  bool _isLoadingMore = false;

  bool get hasMore => _nextCursor != null;

  Future<void> getUnis() async {
    _allUnis.clear();
    _nextCursor = null;
    _isLoadingMore = false;

    emit(BrowseLoading());

    final result = await getUnisUseCase.call();

    result.fold((failure) => emit(BrowseFailure(failure.message)), (response) {
      _allUnis.addAll(response.uniEntities);
      _nextCursor = response.nextCursor;
      return emit(
        BrowseSuccess(uniEntities: List.from(_allUnis), nextCursor: _nextCursor),
      );
    });
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || _nextCursor == null) return;

    _isLoadingMore = true;
    emit(BrowsePaginationLoading(List.from(_allUnis)));

    final result = await getUnisUseCase.call(cursor: _nextCursor);

    result.fold(
      (failure) {
        _isLoadingMore = false;
        emit(
          BrowsePaginationFailure(
            errMessage: failure.message,
            currentUnis: List.from(_allUnis),
          ),
        );
      },
      (response) {
        _allUnis.addAll(response.uniEntities);
        _nextCursor = response.nextCursor;
        _isLoadingMore = false;
        emit(
          BrowseSuccess(
            uniEntities: List.from(_allUnis),
            nextCursor: _nextCursor,
          ),
        );
      },
    );
  }
}

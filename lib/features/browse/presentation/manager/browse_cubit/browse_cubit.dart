import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/features/browse/domain/use_cases/get_unis_use_case.dart';

part 'browse_state.dart';

class BrowseCubit extends Cubit<BrowseState> {
  final GetUnisUseCase getUnisUseCase;

  BrowseCubit(this.getUnisUseCase) : super(BrowseInitial());

  final List<UniEntity> allUnis = [];
  String? nextCursor;
  bool isLoadingMore = false;

  bool get hasMore => nextCursor != null;

  Future<void> getUnis() async {
    allUnis.clear();
    nextCursor = null;
    isLoadingMore = false;

    emit(BrowseLoading());

    final result = await getUnisUseCase.call();

    result.fold((failure) => emit(BrowseFailure(failure.message)), (response) {
      allUnis.addAll(response.uniEntities);
      nextCursor = response.nextCursor;
      return emit(
        BrowseSuccess(uniEntities: List.from(allUnis), nextCursor: nextCursor),
      );
    });
  }

  Future<void> loadMore() async {
    if (isLoadingMore || nextCursor == null) return;

    isLoadingMore = true;
    emit(BrowsePaginationLoading(List.from(allUnis)));

    final result = await getUnisUseCase.call(cursor: nextCursor);

    result.fold(
      (failure) {
        isLoadingMore = false;
        emit(
          BrowsePaginationFailure(
            errMessage: failure.message,
            currentUnis: List.from(allUnis),
          ),
        );
      },
      (response) {
        allUnis.addAll(response.uniEntities);
        nextCursor = response.nextCursor;
        isLoadingMore = false;
        emit(
          BrowseSuccess(
            uniEntities: List.from(allUnis),
            nextCursor: nextCursor,
          ),
        );
      },
    );
  }
}

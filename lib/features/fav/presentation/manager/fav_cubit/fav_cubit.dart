import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/core/entities/uni_entity.dart';
import 'package:uni/features/fav/domain/use_cases/add_to_fav_use_case.dart';
import 'package:uni/features/fav/domain/use_cases/get_favs_use_case.dart';
import 'package:uni/features/fav/domain/use_cases/remove_from_fav_use_case.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  final GetFavsUseCase getFavsUseCase;
  final AddToFavUseCase addToFavUseCase;
  final RemoveFromFavUseCase removeFromFavUseCase;

  FavCubit({
    required this.getFavsUseCase,
    required this.addToFavUseCase,
    required this.removeFromFavUseCase,
  }) : super(FavInitial());

  final List<UniEntity> _allFavs = [];
  String? _nextCursor;
  bool _isLoadingMore = false;

  bool get hasMore => _nextCursor != null;

  final Set<int> _favIds = {};
  Set<int> get favIds => Set.unmodifiable(_favIds);

  Future<void> getFavs() async {
    _allFavs.clear();
    _nextCursor = null;
    _isLoadingMore = false;

    emit(FavLoading());

    final result = await getFavsUseCase.call();

    result.fold((failure) => emit(FavFailure(failure.message)), (response) {
      _allFavs.addAll(response.uniEntities);
      _nextCursor = response.nextCursor;
      _favIds.addAll(_allFavs.map((u) => u.id));
      emit(
        FavSuccess(uniEntities: List.from(_allFavs), nextCursor: _nextCursor),
      );
    });
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || _nextCursor == null) return;

    _isLoadingMore = true;
    emit(FavPaginationLoading(List.from(_allFavs)));

    final result = await getFavsUseCase.call(cursor: _nextCursor);

    result.fold(
      (failure) {
        _isLoadingMore = false;
        emit(
          FavPaginationFailure(
            errMessage: failure.message,
            currentUnis: List.from(_allFavs),
          ),
        );
      },
      (response) {
        _allFavs.addAll(response.uniEntities);
        _nextCursor = response.nextCursor;
        _isLoadingMore = false;
        emit(
          FavSuccess(uniEntities: List.from(_allFavs), nextCursor: _nextCursor),
        );
      },
    );
  }

  Future<void> addToFav(int universityId) async {
    emit(FavActionLoading());
    final result = await addToFavUseCase.call(universityId);
    result.fold((failure) => emit(FavActionFailure(failure.message)), (_) {
      _favIds.add(universityId);
      _allFavs;
      emit(FavActionSuccess());
    });
  }

  // Future<void> removeFromFav(int universityId) async {
  //   emit(FavActionLoading());
  //   final result = await removeFromFavUseCase.call(universityId);
  //   result.fold((failure) => emit(FavActionFailure(failure.message)), (_) {
  //     // نشيله من الـ list locally من غير ما نعمل API call تاني
  //     _favIds.remove(universityId);
  //     _allFavs.removeWhere((uni) => uni.id == universityId);
  //     emit(
  //       FavSuccess(uniEntities: List.from(_allFavs), nextCursor: _nextCursor),
  //     );
  //   });
  // }

  Future<void> removeFromFav(int universityId) async {
  final backup = List<UniEntity>.from(_allFavs);
  final backupIds = Set<int>.from(_favIds);

  // optimistic
  _favIds.remove(universityId);
  _allFavs.removeWhere((uni) => uni.id == universityId);
  emit(FavSuccess(uniEntities: List.from(_allFavs), nextCursor: _nextCursor));

  final result = await removeFromFavUseCase.call(universityId);
  result.fold(
    (failure) {
      // rollback
      _favIds
        ..clear()
        ..addAll(backupIds);
      _allFavs
        ..clear()
        ..addAll(backup);
      emit(FavSuccess(uniEntities: List.from(_allFavs), nextCursor: _nextCursor));
      emit(FavActionFailure(failure.message));
    },
    (_) => emit(FavActionSuccess()),
  );
}
}

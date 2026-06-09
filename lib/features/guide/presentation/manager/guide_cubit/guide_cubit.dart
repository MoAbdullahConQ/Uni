import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/features/guide/domain/entities/guide_article_entity.dart';
import 'package:uni/features/guide/domain/use_cases/get_articles_use_case.dart';

part 'guide_state.dart';

class GuideCubit extends Cubit<GuideState> {
  final GetArticlesUseCase getArticlesUseCase;

  GuideCubit(this.getArticlesUseCase) : super(GuideInitial());

  final List<GuideArticleEntity> _allArticles = [];
  String? _nextCursor;
  bool _isLoadingMore = false;

  bool get hasMore => _nextCursor != null;

  Future<void> getArticles() async {
    _allArticles.clear();
    _nextCursor = null;
    _isLoadingMore = false;

    emit(GuideLoading());

    final result = await getArticlesUseCase.call();

    result.fold(
      (failure) => emit(GuideFailure(failure.message)),
      (response) {
        _allArticles.addAll(response.articles);
        _nextCursor = response.nextCursor;
        emit(GuideSuccess(
          articles: List.from(_allArticles),
          nextCursor: _nextCursor,
        ));
      },
    );
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || _nextCursor == null) return;

    _isLoadingMore = true;
    emit(GuidePaginationLoading(List.from(_allArticles)));

    final result = await getArticlesUseCase.call(cursor: _nextCursor);

    result.fold(
      (failure) {
        _isLoadingMore = false;
        emit(GuidePaginationFailure(
          errMessage: failure.message,
          currentArticles: List.from(_allArticles),
        ));
      },
      (response) {
        _allArticles.addAll(response.articles);
        _nextCursor = response.nextCursor;
        _isLoadingMore = false;
        emit(GuideSuccess(
          articles: List.from(_allArticles),
          nextCursor: _nextCursor,
        ));
      },
    );
  }
}

part of 'guide_cubit.dart';

abstract class GuideState {}

class GuideInitial extends GuideState {}

class GuideLoading extends GuideState {}

class GuideSuccess extends GuideState {
  final List<GuideArticleEntity> articles;
  final String? nextCursor;
  
  GuideSuccess({required this.articles, this.nextCursor});
}

class GuideFailure extends GuideState {
  final String errMessage;

  GuideFailure(this.errMessage);
}

class GuidePaginationLoading extends GuideState {
  final List<GuideArticleEntity> currentArticles;

  GuidePaginationLoading(this.currentArticles);
}

class GuidePaginationFailure extends GuideState {
  final String errMessage;
  final List<GuideArticleEntity> currentArticles;

  GuidePaginationFailure({
    required this.errMessage,
    required this.currentArticles,
  });
}

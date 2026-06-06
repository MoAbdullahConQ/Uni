part of 'trending_cubit.dart';

abstract class TrendingState {}

class TrendingInitial extends TrendingState {}

class TrendingLoading extends TrendingState {}

class TrendingSuccess extends TrendingState {
  final List<TrendingUniEntity> unis;

  TrendingSuccess(this.unis);

  List<String> get trendingSearches => unis.map((u) => u.name).toList();
}

class TrendingEmpty extends TrendingState {}

class TrendingFailure extends TrendingState {
  final String message;

  TrendingFailure(this.message);
}

part of 'recommended_cubit.dart';

abstract class RecommendedState {}

class RecommendedInitial extends RecommendedState {}

class RecommendedLoading extends RecommendedState {}

class RecommendedSuccess extends RecommendedState {
  final List<RecommendedUniEntity> unis;

  RecommendedSuccess(this.unis);
}

class RecommendedEmpty extends RecommendedState {}

class RecommendedFailure extends RecommendedState {
  final String message;
  
  RecommendedFailure(this.message);
}

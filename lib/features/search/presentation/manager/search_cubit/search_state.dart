part of 'search_cubit.dart';

abstract class SearchCubitState {}

class SearchInitial extends SearchCubitState {}

class SearchLoading extends SearchCubitState {}

class SearchSuccess extends SearchCubitState {
  final List<UniEntity> uniEntities;
  final bool hasMore;

  SearchSuccess({required this.uniEntities, this.hasMore = false});
}

class SearchEmpty extends SearchCubitState {}

class SearchFailure extends SearchCubitState {
  final String errMessage;
  SearchFailure(this.errMessage);
}

class SearchPaginationLoading extends SearchCubitState {
  final List<UniEntity> currentUnis;
  SearchPaginationLoading(this.currentUnis);
}

class SearchPaginationFailure extends SearchCubitState {
  final String errMessage;
  final List<UniEntity> currentUnis;
  SearchPaginationFailure({
    required this.errMessage,
    required this.currentUnis,
  });
}

part of 'search_cubit.dart';

abstract class SearchCubitState {}

class SearchInitial extends SearchCubitState {}

class SearchLoading extends SearchCubitState {}

class SearchSuccess extends SearchCubitState {
  final List<UniEntity> uniEntities;
  final String? nextCursor;

  SearchSuccess({required this.uniEntities, this.nextCursor});
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

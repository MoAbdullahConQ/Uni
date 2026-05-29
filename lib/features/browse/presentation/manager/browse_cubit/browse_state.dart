part of 'browse_cubit.dart';

abstract class BrowseState {}

class BrowseInitial extends BrowseState {}

class BrowseLoading extends BrowseState {}

class BrowsePaginationLoading extends BrowseState {
  final List<UniEntity> currentUnis;

  BrowsePaginationLoading(this.currentUnis);
}

class BrowsePaginationFailure extends BrowseState {
  final String errMessage;
  final List<UniEntity> currentUnis;

  BrowsePaginationFailure({
    required this.errMessage,
    required this.currentUnis,
  });
}

class BrowseSuccess extends BrowseState {
  final List<UniEntity> uniEntities;
  final String? nextCursor;

  BrowseSuccess({required this.uniEntities, this.nextCursor});
}

class BrowseFailure extends BrowseState {
  final String errMessage;

  BrowseFailure(this.errMessage);
}

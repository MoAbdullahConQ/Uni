part of 'fav_cubit.dart';

abstract class FavState {}

class FavInitial extends FavState {}

class FavLoading extends FavState {}

class FavSuccess extends FavState {
  final List<UniEntity> uniEntities;
  final String? nextCursor;

  FavSuccess({required this.uniEntities, this.nextCursor});
}

class FavFailure extends FavState {
  final String errMessage;

  FavFailure(this.errMessage);
}

class FavPaginationLoading extends FavState {
  final List<UniEntity> currentUnis;

  FavPaginationLoading(this.currentUnis);
}

class FavPaginationFailure extends FavState {
  final String errMessage;
  final List<UniEntity> currentUnis;

  FavPaginationFailure({required this.errMessage, required this.currentUnis});
}

// states for add/remove
class FavActionLoading extends FavState {}

class FavActionSuccess extends FavState {}

class FavActionFailure extends FavState {
  final String errMessage;
  
  FavActionFailure(this.errMessage);
}

part of 'browse_cubit.dart';

abstract class BrowseState {}

class BrowseInitial extends BrowseState {}

class BrowseLoading extends BrowseState {}

class BrowseSuccess extends BrowseState {
  final List<UniEntity> unis;

  BrowseSuccess(this.unis);
}

class BrowseFailure extends BrowseState {
  final String errMessage;

  BrowseFailure(this.errMessage);
}

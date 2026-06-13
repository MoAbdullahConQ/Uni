import 'package:uni/features/uni_detail/domain/entities/uni_detail_entity.dart';

abstract class UniDetailState {}

class UniDetailInitial extends UniDetailState {}

class UniDetailLoading extends UniDetailState {}

class UniDetailSuccess extends UniDetailState {
  final UniDetailEntity uniDetailEntity;
  UniDetailSuccess(this.uniDetailEntity);
}

class UniDetailFailure extends UniDetailState {
  final String errMessage;
  UniDetailFailure(this.errMessage);
}

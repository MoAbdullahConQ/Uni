import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/faheem/data/data_sources/faheem_remote_data_source.dart';
import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';
import 'package:uni/features/faheem/domain/entities/conversation_details_entity.dart';
import 'package:uni/features/faheem/domain/entities/conversation_entity.dart';
import 'package:uni/features/faheem/domain/repos/faheem_repo.dart';

class FaheemRepoImpl implements FaheemRepo {
  final FaheemRemoteDataSource faheemRemoteDataSource;

  FaheemRepoImpl(this.faheemRemoteDataSource);

  @override
  Future<Either<Failure, ChatMessageEntity>> sendMessage({
    required String message,
    int? conversationId,
  }) async {
    try {
      final result = await faheemRemoteDataSource.sendMessage(
        message: message,
        conversationId: conversationId,
      );
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, List<ConversationEntity>>> getConversations() async {
    try {
      final result = await faheemRemoteDataSource.getConversations();
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }

  @override
  Future<Either<Failure, ConversationDetailsEntity>> getConversationMessages(
    int id,
  ) async {
    try {
      final result = await faheemRemoteDataSource.getConversationMessages(id);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}

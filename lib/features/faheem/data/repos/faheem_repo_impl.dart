import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/faheem/data/data_sources/faheem_remote_data_source.dart';
import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';
import 'package:uni/features/faheem/domain/repos/faheem_repo.dart';

class FaheemRepoImpl implements FaheemRepo {
  final FaheemRemoteDataSource faheemRemoteDataSource;

  FaheemRepoImpl(this.faheemRemoteDataSource);

  @override
  Future<Either<Failure, ChatMessageEntity>> sendMessage({
    required String message,
  }) async {
    try {
      final result =
          await faheemRemoteDataSource.sendMessage(message: message);
      return right(result);
    } on DioException catch (e) {
      return left(ServerFailure.fromDioError(e));
    }
  }
}

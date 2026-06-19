import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';

abstract class FaheemRepo {
  Future<Either<Failure, ChatMessageEntity>> sendMessage({
    required String message,
  });
}

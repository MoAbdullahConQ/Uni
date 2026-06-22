import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';
import 'package:uni/features/faheem/domain/repos/faheem_repo.dart';

class SendMessageUseCase {
  final FaheemRepo faheemRepo;

  SendMessageUseCase(this.faheemRepo);

  Future<Either<Failure, ChatMessageEntity>> call({
    required String message,
    int? conversationId,
  }) {
    return faheemRepo.sendMessage(
      message: message,
      conversationId: conversationId,
    );
  }
}

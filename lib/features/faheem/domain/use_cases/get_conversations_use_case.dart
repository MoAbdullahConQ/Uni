import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/faheem/domain/entities/conversation_entity.dart';
import 'package:uni/features/faheem/domain/repos/faheem_repo.dart';

class GetConversationsUseCase {
  final FaheemRepo faheemRepo;

  GetConversationsUseCase(this.faheemRepo);

  Future<Either<Failure, List<ConversationEntity>>> call() {
    return faheemRepo.getConversations();
  }
}

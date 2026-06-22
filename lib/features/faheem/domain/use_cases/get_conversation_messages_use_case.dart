import 'package:dartz/dartz.dart';
import 'package:uni/core/errors/failures.dart';
import 'package:uni/features/faheem/domain/entities/conversation_details_entity.dart';
import 'package:uni/features/faheem/domain/repos/faheem_repo.dart';

class GetConversationMessagesUseCase {
  final FaheemRepo faheemRepo;

  GetConversationMessagesUseCase(this.faheemRepo);

  Future<Either<Failure, ConversationDetailsEntity>> call(int id) {
    return faheemRepo.getConversationMessages(id);
  }
}

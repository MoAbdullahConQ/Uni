import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';
import 'package:uni/features/faheem/domain/entities/conversation_entity.dart';

abstract class FaheemState {}

class FaheemInitial extends FaheemState {}

// Emitted while waiting for the API response (typing indicator shown)
class FaheemSending extends FaheemState {
  final List<ChatMessageEntity> messages;
  FaheemSending(this.messages);
}

// Emitted after a successful response — holds the full updated message list
class FaheemMessageReceived extends FaheemState {
  final List<ChatMessageEntity> messages;
  FaheemMessageReceived(this.messages);
}

// Emitted on API failure — typing indicator removed, error shown as snackbar
class FaheemSendFailure extends FaheemState {
  final List<ChatMessageEntity> messages;
  final String errMessage;
  FaheemSendFailure({required this.messages, required this.errMessage});
}

// History states
class FaheemConversationsLoading extends FaheemState {}

class FaheemConversationsSuccess extends FaheemState {
  final List<ConversationEntity> conversations;
  FaheemConversationsSuccess(this.conversations);
}

class FaheemConversationsFailure extends FaheemState {
  final String errMessage;
  FaheemConversationsFailure(this.errMessage);
}

// Conversation messages states (opening a chat from history)
class FaheemConversationMessagesLoading extends FaheemState {}

class FaheemConversationMessagesSuccess extends FaheemState {
  final List<ChatMessageEntity> messages;
  FaheemConversationMessagesSuccess(this.messages);
}

class FaheemConversationMessagesFailure extends FaheemState {
  final String errMessage;
  FaheemConversationMessagesFailure(this.errMessage);
}

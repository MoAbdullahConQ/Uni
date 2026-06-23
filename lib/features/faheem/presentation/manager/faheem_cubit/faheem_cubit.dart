import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/features/faheem/data/models/faheem_message_model.dart';
import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';
import 'package:uni/features/faheem/domain/use_cases/get_conversation_messages_use_case.dart';
import 'package:uni/features/faheem/domain/use_cases/get_conversations_use_case.dart';
import 'package:uni/features/faheem/domain/use_cases/send_message_use_case.dart';
import 'package:uni/features/faheem/presentation/manager/faheem_cubit/faheem_state.dart';

class FaheemCubit extends Cubit<FaheemState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetConversationsUseCase getConversationsUseCase;
  final GetConversationMessagesUseCase getConversationMessagesUseCase;

  FaheemCubit({
    required this.sendMessageUseCase,
    required this.getConversationsUseCase,
    required this.getConversationMessagesUseCase,
  }) : super(FaheemInitial());

  final List<ChatMessageEntity> _messages = [];
  int? _currentConversationId;

  List<ChatMessageEntity> get messages => List.unmodifiable(_messages);

  // Called when user opens an existing conversation from history
  void loadConversationMessages(int conversationId) async {
    _currentConversationId = conversationId;
    emit(FaheemConversationMessagesLoading());

    final result = await getConversationMessagesUseCase(conversationId);

    result.fold(
      (failure) => emit(FaheemConversationMessagesFailure(failure.message)),
      (details) {
        _messages.clear();
        // Convert each ConversationMessageEntity to two ChatMessageEntity (user + faheem)
        for (final msg in details.messages) {
          _messages.add(
            ChatMessageEntity(text: msg.message, sender: MessageSender.user),
          );
          _messages.add(
            ChatMessageEntity(text: msg.reply, sender: MessageSender.faheem),
          );
        }
        emit(FaheemConversationMessagesSuccess(List.from(_messages)));
      },
    );
  }

  // Called when user navigates to history screen
  Future<void> loadConversations() async {
    emit(FaheemConversationsLoading());
    final result = await getConversationsUseCase();
    result.fold(
      (failure) => emit(FaheemConversationsFailure(failure.message)),
      (conversations) => emit(FaheemConversationsSuccess(conversations)),
    );
  }

  // Clears state to start a fresh new conversation
  void startNewConversation() {
    _messages.clear();
    _currentConversationId = null;
    emit(FaheemInitial());
  }

  Future<void> sendMessage(String text) async {
    // Add user message
    _messages.add(ChatMessageEntity(text: text, sender: MessageSender.user));

    // Add typing indicator
    _messages.add(
      const ChatMessageEntity(sender: MessageSender.faheem, isTyping: true),
    );

    emit(FaheemSending(List.from(_messages)));

    final result = await sendMessageUseCase(
      message: text,
      conversationId: _currentConversationId,
    );

    // Remove typing indicator
    _messages.removeWhere((m) => m.isTyping);

    result.fold(
      (failure) {
        emit(
          FaheemSendFailure(
            messages: List.from(_messages),
            errMessage: failure.message,
          ),
        );
      },
      (faheemMessage) {
        // Capture conversation_id from response if not already set
        if (_currentConversationId == null &&
            faheemMessage is FaheemMessageModel) {
          _currentConversationId = faheemMessage.conversationId;
        }
        _messages.add(faheemMessage);
        emit(FaheemMessageReceived(List.from(_messages)));
      },
    );
  }
}

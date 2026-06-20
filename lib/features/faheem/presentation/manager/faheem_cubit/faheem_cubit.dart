import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni/features/faheem/domain/entities/chat_message_entity.dart';
import 'package:uni/features/faheem/domain/use_cases/send_message_use_case.dart';
import 'package:uni/features/faheem/presentation/manager/faheem_cubit/faheem_state.dart';

class FaheemCubit extends Cubit<FaheemState> {
  final SendMessageUseCase sendMessageUseCase;

  FaheemCubit(this.sendMessageUseCase) : super(FaheemInitial());

  final List<ChatMessageEntity> _messages = [];

  List<ChatMessageEntity> get messages => List.unmodifiable(_messages);

  Future<void> sendMessage(String text) async {
    // Add user message
    _messages.add(ChatMessageEntity(text: text, sender: MessageSender.user));

    // Add typing indicator
    _messages.add(
      const ChatMessageEntity(sender: MessageSender.faheem, isTyping: true),
    );

    emit(FaheemSending(List.from(_messages)));

    final result = await sendMessageUseCase(message: text);

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
        _messages.add(faheemMessage);
        emit(FaheemMessageReceived(List.from(_messages)));
      },
    );
  }
}

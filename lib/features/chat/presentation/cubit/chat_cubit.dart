import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/entities/user.dart';
import '../../domain/enums/message_status.dart';
import '../../domain/repositories/chat_repository.dart';
import 'chat_state.dart';

/// Управляет состоянием чата и отправкой сообщений.
final class ChatCubit({
  required final ChatRepository _repository,
  required final String chatId,
  required final User currentUser,
}) extends Cubit<ChatState> {
  this : super(ChatState.initial());

  static const _uuid = Uuid();

  /// Загружает историю сообщений.
  Future<void> loadMessages() async {
    emit(ChatState.loading());

    try {
      final (messages, chatInfo) = await (
        _repository.getMessages(chatId),
        _repository.getChatInfo(chatId),
      ).wait;

      if (isClosed) return;

      emit(
        ChatState.loaded(
          messages: messages,
          chatInfo: chatInfo,
        ),
      );
    } catch (error) {
      if (isClosed) return;

      emit(ChatState.failure(message: 'Не удалось загрузить историю'));
    }
  }

  /// Создаёт и отправляет новое сообщение.
  Future<void> sendMessage(String text) async {
    final trimmedText = text.trim();

    if (trimmedText.isEmpty || state is! ChatLoaded) {
      return;
    }

    final clientId = _uuid.v4();

    final message = ChatMessage(
      id: clientId,
      clientId: clientId,
      chatId: chatId,
      authorId: currentUser.id,
      text: trimmedText,
      status: MessageStatus.pending,
      createdAt: DateTime.now(),
    );

    final currentState = state as ChatLoaded;

    emit(
      currentState.copyWith(
        messages: [...currentState.messages, message],
      ),
    );

    await _sendMessage(message);
  }

  /// Повторно отправляет сообщение с указанным идентификатором.
  Future<void> retryMessage(String clientId) async {
    final currentState = state;

    if (currentState is! ChatLoaded) return;

    final message = currentState.messages.where((item) => item.clientId == clientId).firstOrNull;

    if (message == null || message.status != MessageStatus.failed) {
      return;
    }

    final pendingMessage = message.copyWith(
      status: MessageStatus.pending,
    );

    _updateMessage(pendingMessage);

    await _sendMessage(pendingMessage);
  }

  /// Отправляет сообщение и обновляет его статус.
  Future<void> _sendMessage(ChatMessage message) async {
    try {
      await _repository.sendMessage(message);

      if (isClosed) return;

      _updateMessage(
        message.copyWith(status: MessageStatus.sent),
      );
    } catch (_) {
      if (isClosed) return;

      _updateMessage(
        message.copyWith(status: MessageStatus.failed),
      );
    }
  }

  /// Обновляет сообщение в текущем состоянии.
  void _updateMessage(ChatMessage message) {
    final currentState = state;

    if (currentState is! ChatLoaded) return;

    final messages = currentState.messages.map((item) {
      return item.clientId == message.clientId ? message : item;
    }).toList();

    emit(currentState.copyWith(messages: messages));
  }
}

import 'package:equatable/equatable.dart';

import '../../domain/entities/chat_info.dart';
import '../../domain/entities/chat_message.dart';

/// Состояние экрана чата.
sealed class ChatState extends Equatable {
  const ChatState();

  /// Создаёт начальное состояние.
  const factory ChatState.initial() = ChatInitial;

  /// Создаёт состояние загрузки.
  const factory ChatState.loading() = ChatLoading;

  /// Создаёт состояние с загруженными сообщениями.
  const factory ChatState.loaded({
    required List<ChatMessage> messages,
    required ChatInfo chatInfo,
  }) = ChatLoaded;

  /// Создаёт состояние ошибки загрузки.
  const factory ChatState.failure({required String message}) = ChatFailure;
}

/// Начальное состояние чата.
final class const ChatInitial() extends ChatState {
  @override
  List<Object?> get props => [];
}

/// Загрузка истории сообщений.
final class const ChatLoading() extends ChatState {
  @override
  List<Object?> get props => [];
}

/// История сообщений загружена.
final class const ChatLoaded({
  required final List<ChatMessage> messages,
  required final ChatInfo chatInfo,
}) extends ChatState {
  /// Создаёт копию состояния с обновлёнными данными.
  ChatLoaded copyWith({
    List<ChatMessage>? messages,
    ChatInfo? chatInfo,
  }) {
    return ChatLoaded(
      messages: messages ?? this.messages,
      chatInfo: chatInfo ?? this.chatInfo,
    );
  }

  @override
  List<Object?> get props => [messages, chatInfo];
}

/// Не удалось загрузить историю сообщений.
final class const ChatFailure({
  required final String message,
}) extends ChatState {
  @override
  List<Object?> get props => [message];
}

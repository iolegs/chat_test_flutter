import 'package:equatable/equatable.dart';

import '../../domain/entities/chat_message.dart';

/// Состояние экрана чата.
sealed class ChatState extends Equatable {
  const ChatState();

  /// Создаёт начальное состояние.
  const factory ChatState.initial() = ChatInitial;

  /// Создаёт состояние загрузки.
  const factory ChatState.loading() = ChatLoading;

  /// Создаёт состояние с загруженными сообщениями.
  const factory ChatState.loaded({required List<ChatMessage> messages}) = ChatLoaded;

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
}) extends ChatState {
  /// Создаёт копию состояния с обновлённым списком сообщений.
  ChatLoaded copyWith({List<ChatMessage>? messages}) {
    return ChatLoaded(messages: messages ?? this.messages);
  }

  @override
  List<Object?> get props => [messages];
}

/// Не удалось загрузить историю сообщений.
final class const ChatFailure({
  required final String message,
}) extends ChatState {
  @override
  List<Object?> get props => [message];
}

import 'package:equatable/equatable.dart';

import '../enums/message_status.dart';

/// Сообщение в чате.
final class const ChatMessage({
  /// Уникальный идентификатор сообщения.
  required final String id,

  /// Идентификатор клиентской отправки, сохраняемый при повторе.
  required final String clientId,

  /// Идентификатор чата.
  required final String chatId,

  /// Идентификатор автора сообщения.
  required final String authorId,

  /// Текст сообщения.
  required final String text,

  /// Текущий статус доставки.
  required final MessageStatus status,

  /// Время создания сообщения.
  required final DateTime createdAt,
}) extends Equatable {
  /// Создаёт копию сообщения с обновлённым статусом.
  ChatMessage copyWith({MessageStatus? status}) {
    return ChatMessage(
      id: id,
      clientId: clientId,
      chatId: chatId,
      authorId: authorId,
      text: text,
      status: status ?? this.status,
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    clientId,
    chatId,
    authorId,
    text,
    status,
    createdAt,
  ];
}

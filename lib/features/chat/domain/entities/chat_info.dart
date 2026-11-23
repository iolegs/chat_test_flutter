import 'user.dart';

/// Метаданные чата.
final class ChatInfo({
  /// Идентификатор чата.
  required final String id,

  /// Собеседник (для личных чатов).
  required final User peer,

  /// Пользовательское название чата, если задано.
  final String? title,
});

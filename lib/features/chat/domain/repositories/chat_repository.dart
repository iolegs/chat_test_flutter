import '../entities/chat_message.dart';

/// Контракт для работы с сообщениями чата.
abstract interface class ChatRepository {
  /// Возвращает историю сообщений указанного чата.
  Future<List<ChatMessage>> getMessages(String chatId);

  /// Отправляет сообщение в указанный чат.
  Future<void> sendMessage(ChatMessage message);
}

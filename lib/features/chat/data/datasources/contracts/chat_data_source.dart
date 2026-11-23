import 'package:chat_test/features/chat/domain/entities/chat_message.dart';

/// Контракт источника данных чата.
abstract interface class ChatDataSource {
  /// Возвращает сообщения указанного чата.
  Future<List<ChatMessage>> getMessages(String chatId);

  /// Отправляет сообщение на удалённый сервер.
  Future<void> sendMessage(ChatMessage message);
}

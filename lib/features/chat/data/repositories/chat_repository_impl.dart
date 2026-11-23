import 'package:chat_test/features/chat/domain/entities/chat_message.dart';
import 'package:chat_test/features/chat/domain/repositories/chat_repository.dart';

import '../datasources/contracts/chat_data_source.dart';

/// Реализация репозитория для работы с сообщениями чата.
final class ChatRepositoryImpl({
  required final ChatDataSource dataSource,
}) implements ChatRepository {
  @override
  Future<List<ChatMessage>> getMessages(String chatId) {
    return dataSource.getMessages(chatId);
  }

  @override
  Future<void> sendMessage(ChatMessage message) {
    return dataSource.sendMessage(message);
  }
}

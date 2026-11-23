import 'package:chat_test/features/chat/domain/entities/chat_message.dart';
import 'package:chat_test/features/chat/domain/enums/message_status.dart';

import '../../../domain/entities/chat_info.dart';
import '../contracts/chat_data_source.dart';
import 'fake_chat_fixtures.dart';

/// Имитация удалённого источника сообщений.
final class FakeChatRemoteDataSource() implements ChatDataSource {
  final List<ChatMessage> _messages = FakeChatFixtures.buildMessages();
  final Map<String, int> _attemptsByClientId = {};

  @override
  Future<List<ChatMessage>> getMessages(String chatId) async {
    return List.unmodifiable(
      _messages.where((message) => message.chatId == chatId),
    );
  }

  @override
  Future<ChatInfo> getChatInfo(String chatId) async {
    return ChatInfo(
      id: chatId,
      peer: FakeChatFixtures.peerUser,
    );
  }

  @override
  Future<void> sendMessage(ChatMessage message) async {
    await Future.delayed(const Duration(milliseconds: 700));

    final attempt = (_attemptsByClientId[message.clientId] ?? 0) + 1;
    _attemptsByClientId[message.clientId] = attempt;

    if (attempt == 1) {
      throw Exception('Имитация ошибки отправки');
    }

    // Повторная отправка не должна создавать дубликат.
    _messages.removeWhere((item) => item.clientId == message.clientId);
    _messages.add(message.copyWith(status: MessageStatus.sent));
  }
}

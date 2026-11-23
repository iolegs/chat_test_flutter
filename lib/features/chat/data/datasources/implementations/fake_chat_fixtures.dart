import '../../../domain/entities/chat_message.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/enums/message_status.dart';

/// Фикстуры тестового чата: идентификатор, участники и предзаполненная история.
/// Вынесены отдельно, чтобы значения не разъезжались между seed, ChatInfo и точкой входа.
abstract final class FakeChatFixtures {
  /// Идентификатор тестового чата.
  static const chatId = 'room1';

  /// Текущий пользователь (автор исходящих сообщений).
  static const currentUser = User(id: 'user_oleg', name: 'Олег');

  /// Собеседник в тестовом чате.
  static const peerUser = User(id: 'user_alexey', name: 'Алексей');

  /// Предзаполненная история чата.
  static List<ChatMessage> buildMessages() {
    final now = DateTime.now();
    return [
      ChatMessage(
        id: 'message_1',
        clientId: 'message_1',
        chatId: chatId,
        authorId: peerUser.id,
        text: 'Привет! Как продвигается тестовое задание?',
        status: MessageStatus.sent,
        createdAt: now.subtract(const Duration(minutes: 15)),
      ),
      ChatMessage(
        id: 'message_2',
        clientId: 'message_2',
        chatId: chatId,
        authorId: currentUser.id,
        text: 'Привет! Да вот, закончил с архитектурой, перехожу к UI.',
        status: MessageStatus.sent,
        createdAt: now.subtract(const Duration(minutes: 14)),
      ),
      ChatMessage(
        id: 'message_3',
        clientId: 'message_3',
        chatId: chatId,
        authorId: peerUser.id,
        text: 'О, круто. Чистую архитектуру используешь?',
        status: MessageStatus.sent,
        createdAt: DateTime.now().subtract(const Duration(minutes: 12)),
      ),
      ChatMessage(
        id: 'message_4',
        clientId: 'message_4',
        chatId: chatId,
        authorId: currentUser.id,
        text: 'Да, решил разбить на слои data, domain и presentation.',
        status: MessageStatus.sent,
        createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
      ),
      ChatMessage(
        id: 'message_5',
        clientId: 'message_5',
        chatId: chatId,
        authorId: peerUser.id,
        text: 'Солидно. А стейт-менеджмент какой?',
        status: MessageStatus.sent,
        createdAt: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      ChatMessage(
        id: 'message_6',
        clientId: 'message_6',
        chatId: chatId,
        authorId: currentUser.id,
        text: 'Взял Cubit из flutter_bloc, состояния через sealed классы.',
        status: MessageStatus.sent,
        createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ChatMessage(
        id: 'message_7',
        clientId: 'message_7',
        chatId: chatId,
        authorId: peerUser.id,
        text: 'Отличный выбор! Удачи с оставшейся частью.',
        status: MessageStatus.sent,
        createdAt: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
    ];
  }
}

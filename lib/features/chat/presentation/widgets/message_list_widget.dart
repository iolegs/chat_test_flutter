import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/enums/message_status.dart';
import '../components/message_bubble.dart';
import '../components/message_failed_indicator.dart';
import '../components/message_pending_indicator.dart';
import '../components/message_sent_indicator.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';

/// Виджет списка сообщений чата.
class const MessageListWidget({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        return switch (state) {
          ChatInitial() => const SizedBox.shrink(),
          ChatLoading() => const Center(child: CircularProgressIndicator()),
          ChatFailure(:final message) => Center(child: Text(message)),
          ChatLoaded(:final messages) => ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[messages.length - 1 - index];
              final cubit = context.read<ChatCubit>();
              final isMe = message.authorId == cubit.currentUser.id;

              return MessageBubble(
                text: message.text,
                time:
                    '${message.createdAt.hour.toString().padLeft(2, '0')}:'
                    '${message.createdAt.minute.toString().padLeft(2, '0')}',
                isMe: isMe,
                trailing: _buildTrailing(message, cubit, isMe),
              );
            },
          ),
        };
      },
    );
  }

  /// Выбирает нужный тупой компонент статуса в зависимости от доменного статуса.
  Widget? _buildTrailing(ChatMessage message, ChatCubit cubit, bool isMe) {
    if (!isMe) return null;

    return switch (message.status) {
      MessageStatus.pending => const MessagePendingIndicator(),
      MessageStatus.sent => const MessageSentIndicator(),
      MessageStatus.failed => MessageFailedIndicator(
        onRetry: () => cubit.retryMessage(message.clientId),
      ),
    };
  }
}

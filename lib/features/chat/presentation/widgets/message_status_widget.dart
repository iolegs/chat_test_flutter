import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/enums/message_status.dart';
import '../components/message_failed_indicator.dart';
import '../components/message_pending_indicator.dart';
import '../components/message_sent_indicator.dart';
import '../cubit/chat_cubit.dart';

/// Индикатор статуса сообщения.
/// Выбирает нужный dumb-индикатор по доменному [MessageStatus].
class const MessageStatusWidget({
  super.key,

  /// Сообщение, для которого рендерится индикатор статуса.
  required final ChatMessage message,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return switch (message.status) {
      MessageStatus.pending => const MessagePendingIndicator(),
      MessageStatus.sent => const MessageSentIndicator(),
      MessageStatus.failed => MessageFailedIndicator(
        onRetry: () => context.read<ChatCubit>().retryMessage(message.clientId),
      ),
    };
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../components/message_bubble.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';
import '../extensions/date_time_extensions.dart';
import 'message_status_widget.dart';

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
                time: message.createdAt.formattedTime,
                isMe: isMe,
                trailing: MessageStatusWidget(message: message),
              );
            },
          ),
        };
      },
    );
  }
}

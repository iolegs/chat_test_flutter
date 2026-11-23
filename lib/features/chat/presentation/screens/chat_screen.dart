import 'package:chat_test/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/chat_repository.dart';
import '../widgets/message_composer_widget.dart';
import '../widgets/message_list_widget.dart';

class const ChatScreen({
  super.key,
  required final String chatId,
  required final User currentUser,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(
        repository: context.read<ChatRepository>(),
        chatId: chatId,
        currentUser: currentUser,
      )..loadMessages(),
      child: Scaffold(
        appBar: AppBar(title: Text(chatId)),
        body: const Column(
          children: [
            Expanded(child: MessageListWidget()),
            MessageComposerWidget(),
          ],
        ),
      ),
    );
  }
}

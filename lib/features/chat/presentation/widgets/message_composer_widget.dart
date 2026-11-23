import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../components/message_composer.dart';
import '../cubit/chat_cubit.dart';
import '../cubit/chat_state.dart';

/// Виджет панели ввода.
class const MessageComposerWidget({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      builder: (context, state) {
        if (state is! ChatLoaded) return const SizedBox.shrink();

        return MessageComposer(
          onSend: (text) => context.read<ChatCubit>().sendMessage(text),
        );
      },
    );
  }
}

import 'package:material_ui/material_ui.dart';

/// Индикатор отправки сообщения.
class const MessagePendingIndicator({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 12,
      height: 12,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}

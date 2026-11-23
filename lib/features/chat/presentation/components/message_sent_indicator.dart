import 'package:material_ui/material_ui.dart';

/// Индикатор успешной отправки.
class const MessageSentIndicator({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.check,
      size: 14,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}

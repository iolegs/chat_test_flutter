import 'package:material_ui/material_ui.dart';

/// Индикатор ошибки с кнопкой повтора.
class const MessageFailedIndicator({
  super.key,

  /// Колбэк для повтора отправки.
  required final VoidCallback onRetry,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onRetry,
      child: Row(
        spacing: 4,
        children: [
          Icon(Icons.error, size: 14, color: theme.colorScheme.error),
          Text(
            'Повторить',
            style: TextStyle(
              color: theme.colorScheme.error,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

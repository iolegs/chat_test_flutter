import 'package:material_ui/material_ui.dart';

import '../../domain/enums/message_status.dart';

/// Тупой компонент индикатора статуса доставки сообщения.
class MessageStatusIndicator extends StatelessWidget {
  const MessageStatusIndicator({
    super.key,
    required this.status,
    this.onRetry,
  });

  /// Текущий статус доставки.
  final MessageStatus status;

  /// Колбэк повтора; используется только для [MessageStatus.failed].
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return switch (status) {
      MessageStatus.pending => const SizedBox(
        width: 12,
        height: 12,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      MessageStatus.sent => Icon(
        Icons.check,
        size: 14,
        color: theme.colorScheme.primary,
      ),
      MessageStatus.failed => InkWell(
        onTap: onRetry,
        child: Row(
          children: [
            Icon(Icons.error, size: 14, color: theme.colorScheme.error),
            const SizedBox(width: 4),
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
      ),
    };
  }
}

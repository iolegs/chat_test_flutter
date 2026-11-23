import 'package:material_ui/material_ui.dart';

/// Компонент для отображения одного сообщения в виде пузыря.
class const MessageBubble({
  super.key,
  required final String text,
  required final String time,
  required final bool isMe,
  final Widget? trailing,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Ограничиваем ширину пузыря ~78% экрана, чтобы длинные сообщения
    // не прилипали к противоположному краю.
    final maxBubbleWidth = MediaQuery.sizeOf(context).width * 0.78;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: maxBubbleWidth),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? theme.colorScheme.primaryContainer : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 4,
          children: [
            Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isMe ? theme.colorScheme.onPrimaryContainer : theme.colorScheme.onSurface,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 4,
              children: [
                Text(time, style: theme.textTheme.labelSmall),
                ?trailing,
              ],
            ),
          ],
        ),
      ),
    );
  }
}

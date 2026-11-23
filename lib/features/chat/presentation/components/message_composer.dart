import 'package:material_ui/material_ui.dart';

/// Компонент поля ввода и кнопки отправки сообщения.
class const MessageComposer({
  super.key,
  required final ValueChanged<String> onSend,
}) extends StatefulWidget {
  @override
  State<MessageComposer> createState() => _MessageComposerState();
}

class _MessageComposerState extends State<MessageComposer> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          spacing: 8,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _handleSend(),
                decoration: const InputDecoration(
                  hintText: 'Сообщение...',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (context, value, child) {
                final isEmpty = value.text.trim().isEmpty;
                return IconButton.filled(
                  onPressed: isEmpty ? null : _handleSend,
                  icon: const Icon(Icons.send),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

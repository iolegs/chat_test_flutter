import 'package:material_ui/material_ui.dart';

import '../../features/chat/data/datasources/implementations/fake_chat_fixtures.dart';
import '../../features/chat/domain/entities/user.dart';
import '../../features/chat/presentation/screens/chat_screen.dart';

/// Корневой виджет приложения.
class const AppWidget({
  super.key,

  /// Текущий авторизованный пользователь.
  required final User currentUser,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      // Единственный экран — чат room1.
      home: ChatScreen(
        chatId: FakeChatFixtures.chatId,
        currentUser: currentUser,
      ),
    );
  }
}

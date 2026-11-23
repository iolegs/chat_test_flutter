import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import 'app/widgets/app_widget.dart';
import 'features/chat/data/datasources/implementations/chat_fake_remote_data_source.dart';
import 'features/chat/data/datasources/implementations/fake_chat_fixtures.dart';
import 'features/chat/data/repositories/chat_repository_impl.dart';
import 'features/chat/domain/repositories/chat_repository.dart';

void main() {
  final chatRepository = ChatRepositoryImpl(
    dataSource: FakeChatRemoteDataSource(),
  );

  const currentUser = FakeChatFixtures.currentUser;

  runApp(
    RepositoryProvider<ChatRepository>.value(
      value: chatRepository,
      child: AppWidget(currentUser: currentUser),
    ),
  );
}

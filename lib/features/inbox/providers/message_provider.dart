import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/inbox/repositories/messages_repository.dart';
import 'package:tiktok_clone/features/inbox/view_models/messages_view_model.dart';

final messagesRepositoryProvider = Provider(
  (ref) => MessagesRepository(),
);

final messagesProvider = AsyncNotifierProvider<MessagesViewModel, void>(
  () => MessagesViewModel(),
);

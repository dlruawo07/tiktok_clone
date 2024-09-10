import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';
import 'package:tiktok_clone/features/inbox/providers/message_provider.dart';
import 'package:tiktok_clone/features/inbox/repositories/messages_repository.dart';

class MessagesViewModel extends AsyncNotifier<void> {
  late final MessagesRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(messagesRepositoryProvider);
  }

  Future<void> sendMessage(String text) async {
    final user = ref.read(authRepositoryProvider).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        //
        final message = MessageModel(
          text: text,
          userId: user!.uid,
          createdAt: DateTime.now().millisecondsSinceEpoch,
        );
        _repository.sendMessage(message);
      },
    );
  }
}

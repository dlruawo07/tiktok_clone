import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/providers/auth_provider.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';
import 'package:tiktok_clone/features/inbox/providers/message_provider.dart';
import 'package:tiktok_clone/features/inbox/repositories/messages_repository.dart';

class MessagesViewModel extends FamilyAsyncNotifier<void, String> {
  late final MessagesRepository _repository;
  late final String _chatRoomId;

  @override
  FutureOr<void> build(String arg) {
    _repository = ref.read(messagesRepositoryProvider);
    _chatRoomId = arg;
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
        _repository.sendMessage(_chatRoomId, message);
      },
    );
  }

  Future<void> createChatRoom() async {
    await _repository.createChatRoom(_chatRoomId);
  }

  Future<Map<String, dynamic>> getLatestMessage() async {
    return (await _repository.getLatestMessage(_chatRoomId));
  }

  Future<void> deleteMessage(MessageModel message) async {
    final now = DateTime.now().millisecondsSinceEpoch;
    if (now - message.createdAt > 240000) {
      return;
    }
    final messageId = await _repository.getMessageId(_chatRoomId, message);
    await _repository.updateMessage(_chatRoomId, messageId);
  }
}

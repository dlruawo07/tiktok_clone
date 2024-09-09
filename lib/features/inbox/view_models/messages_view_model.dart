import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repositories/authentication_repository.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';
import 'package:tiktok_clone/features/inbox/repositories/messages_repository.dart';

class MessagesViewModel extends AsyncNotifier<void> {
  late final MessagesRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(messagesRepository);
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

final messagesProvider = AsyncNotifierProvider<MessagesViewModel, void>(
  () => MessagesViewModel(),
);

// returns Stream(connection between you and backend)
// riverpod will tell us when there is data or new data inserted
// API is the same as AsyncNotifierProvider. (except that data doesn't come only once, but realtime: at any point)
// autoDispose: clear messages when user exits chat room (stop listening) (kill connection with firebase when exits screen)
final chatProvider = StreamProvider.autoDispose<List<MessageModel>>((ref) {
  final db = FirebaseFirestore.instance;

  return db
      .collection("chat_rooms")
      .doc("rFaL700U4XZ67StI4lnV")
      .collection("texts")
      .orderBy("createdAt")
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) => MessageModel.fromJson(
                doc.data(),
              ),
            )
            .toList()
            .reversed
            .toList(),
      );
});

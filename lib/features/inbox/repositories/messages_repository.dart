import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';

class MessagesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(String chatId, MessageModel message) async {
    await _db
        .collection("chat_rooms")
        .doc(chatId)
        .collection("texts")
        .add(message.toJson());
  }

  Future<void> createChatRoom(String chatId) async {
    final snapshot = await _db
        .collection("chat_rooms")
        .doc(chatId)
        .collection("texts")
        .limit(1)
        .get();
    if (snapshot.docs.isNotEmpty) {
      return;
    }
    await _db.collection("chat_rooms").doc(chatId).collection("texts").add(
      {
        "test": "message",
      },
    );
  }

  Future<Map<String, dynamic>> getLatestMessage(String chatId) async {
    final snapshot = await _db
        .collection("chat_rooms")
        .doc(chatId)
        .collection("texts")
        .orderBy(
          "createdAt",
          descending: true,
        )
        .limit(1)
        .get();
    return snapshot.docs.first.data();
  }

  Future<String> getMessageId(String chatId, MessageModel message) async {
    final snapshot = await _db
        .collection("chat_rooms")
        .doc(chatId)
        .collection("texts")
        .where("createdAt", isEqualTo: message.createdAt)
        .where("text", isEqualTo: message.text)
        .where("userId", isEqualTo: message.userId)
        .get();
    return snapshot.docs.first.reference.id;
  }

  Future<void> updateMessage(String chatId, String messageId) async {
    await _db
        .collection("chat_rooms")
        .doc(chatId)
        .collection("texts")
        .doc(messageId)
        .update({"text": "[Message is deleted.]"});
  }
}

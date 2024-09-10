import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tiktok_clone/features/inbox/models/message_model.dart';

class MessagesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(MessageModel message) async {
    await _db
        .collection("chat_rooms")
        .doc("rFaL700U4XZ67StI4lnV")
        .collection("texts")
        .add(message.toJson());
  }
}

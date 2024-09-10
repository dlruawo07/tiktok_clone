String createChatId(String uid, String uid2) {
  return uid.compareTo(uid2) < 0 ? "$uid-with-$uid2" : "$uid2-with-$uid";
}

String getRecipientUid(String chatId, String myUid) {
  final List<String> uids = chatId.split("-with-");
  return uids[0] == myUid ? uids[1] : uids[0];
}

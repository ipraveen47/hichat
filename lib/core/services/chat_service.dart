import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final _fire = FirebaseFirestore.instance;

  saveMessage(Map<String, dynamic> message, String chatRoomId) async {
    try {
      await _fire
          .collection("ChatRooms")
          .doc(chatRoomId)
          .collection("messages")
          .add(message);
    } catch (e) {
      rethrow;
    }
  }

  updateLastMessage(String currentuid, String recieveruid, String message,
      int timestamp) async {
    try {
      await _fire.collection("users").doc(currentuid).update({
        "lastMessage": {
          "content": message,
          "timestamp": timestamp,
          "senderId": currentuid,
        },
        "unreadCounter": FieldValue.increment(1)
      });
      await _fire.collection("users").doc(recieveruid).update({
        "lastMessage": {
          "content": message,
          "timestamp": timestamp,
          "senderId": currentuid,
        },
        "unreadCounter": 0
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(String chatRoomId) {
    return _fire
        .collection("ChatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}

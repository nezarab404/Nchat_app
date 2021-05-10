import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMethods {
  getUserByUsename(String username) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .get();
  }

  getUserByUserEmail(String userEmail) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: userEmail)
        .get();
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .onError((error, stackTrace) => print(error.toString()));
  }

  addConversationsMessages(String chatRoomId, messagesMap) {
    FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(messagesMap);
  }

  getConversationsMessages(String chatRoomId) async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: true)
        .snapshots();
  }

  getChatRooms(String username)async {
    return await FirebaseFirestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: username)
        .snapshots();
  }
}

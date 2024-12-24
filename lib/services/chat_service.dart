import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      String sender, String recipient, String message) async {
    final chatId = [sender, recipient]..sort();
    await _firestore.collection('chats').add({
      'sender': sender,
      'recipient': recipient,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
      'chatId': chatId.join('_'),
    });
  }

  Stream<List<Map<String, dynamic>>> getChatMessages(
      String user1, String user2) {
    final chatId = [user1, user2]..sort();
    return _firestore
        .collection('chats')
        .where('chatId', isEqualTo: chatId.join('_'))
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}

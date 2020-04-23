import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csci3100/models/message.dart';

class MessageDB{
  final CollectionReference chatRoomCollection = Firestore.instance.collection('chatRoom');

  final String uid;
  final String chatRoomId;
  final bool isUser1;
  MessageDB({this.uid, this.chatRoomId, this.isUser1});


  Future resetUnread(bool isUser1) async {
    return isUser1 ? await chatRoomCollection.document(chatRoomId).updateData({'user1Unread': 0,})
        : await chatRoomCollection.document(chatRoomId).updateData({'user2Unread': 0,});
  }

  Future sendMessage(String text, String time) async {
    DocumentReference doc = chatRoomCollection.document(chatRoomId);
    isUser1 ? await doc.updateData({'user2Unread': FieldValue.increment(1)})
        : await doc.updateData({'user1Unread': FieldValue.increment(1),});
    await doc.updateData({'lastModify': time});
    return await doc.collection('messages').add({
      'text': text,
      'time': time,
      'from': uid,
    });
  }

  Stream<List<Message>> get messages{
    return chatRoomCollection.document(chatRoomId)
        .collection('messages').orderBy('time').snapshots()
        .map(_messageListFromSnapshot);
  }

  List<Message> _messageListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Message(
        time: doc.data['time'] ?? '',
        text: doc.data['text'] ?? '',
        from: doc.data['from'] ?? '',
      );
    }).toList();
  }

  Stream<QuerySnapshot> get chatRooms{
    return chatRoomCollection.orderBy('lastModify', descending: true).snapshots();
  }

}
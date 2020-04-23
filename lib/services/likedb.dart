import 'package:cloud_firestore/cloud_firestore.dart';

class LikeDB{
  final CollectionReference likeCollection = Firestore.instance.collection('likes');
  final CollectionReference dislikeCollection = Firestore.instance.collection('dislikes');
  final CollectionReference chatRoomCollection = Firestore.instance.collection('chatRoom');

  final String uid;
  LikeDB({this.uid});

  Future sendLike(String targetId) async {
    bool isUser1 = uid.compareTo(targetId) == -1;
    QuerySnapshot qs = await likeCollection.where('to', isEqualTo: uid)
        .where('from', isEqualTo: targetId).getDocuments();
    int len = qs.documents.length;

    //if they never like before
    if (len == 0){
      likeCollection.document().setData({
        "from": uid,
        'to': targetId
      });
    }
    //if both of them like each other, create chatroom
    else if (len == 1){
      likeCollection.document().setData({
        "from": uid,
        'to': targetId
      });
      chatRoomCollection.document().setData({
        "lastModify": DateTime.now().toIso8601String().toString(),
        "user1": isUser1 ? uid : targetId,
        "user2": isUser1 ? targetId : uid,
        "user1Unread": 0,
        "user2Unread": 0
      });
    }
  }


  Future sendDislike(String targetId) async {
    dislikeCollection.document().setData({
      "from": uid,
      'to': targetId
    });
  }


  Stream<QuerySnapshot> get likes{
    return likeCollection.where("from", isEqualTo: uid).snapshots();
  }

  Stream<QuerySnapshot> get dislikes{
    return dislikeCollection.where("from", isEqualTo: uid).snapshots();
  }
}
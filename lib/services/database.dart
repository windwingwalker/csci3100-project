import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csci3100/models/message.dart';
import 'package:csci3100/models/user.dart';

class DatabaseService{
  final CollectionReference userCollection = Firestore.instance.collection('user');
  final CollectionReference chatRoomCollection = Firestore.instance.collection('chatRoom');
  final CollectionReference likeCollection = Firestore.instance.collection('likes');
  final CollectionReference dislikeCollection = Firestore.instance.collection('dislikes');

  final String uid;
  final String chatRoomId;
  final String targetId;
  final bool isUser1;
  DatabaseService({this.uid, this.chatRoomId, this.targetId, this.isUser1});

  Future setFirst() async {
    return await userCollection.document(uid).setData({
      "firstLogin": true,
    });
  }

  Future setSelfInfo(String name, double age, String gender, String college) async {
    return await userCollection.document(uid).updateData({
      "name": name,
      "age": age,
      "gender": gender,
      "college": college,
      "firstLogin": false,
    });
  }

  Future setTargetInfo(String gender, double start, double end) async {
    return await userCollection.document(uid).updateData({
      "targetGender": gender,
      "targetAgeStart": start,
      "targetAgeEnd": end,
    });
  }

  Future setDesc(String desc) async {
    return await userCollection.document(uid).updateData({
      "description": desc,
    });
  }

  //input a data into firestore
  Future updateUserData(String name, double age, String college, String gender) async {
    return await userCollection.document(uid).updateData({
      "name": name,
      "gender": gender,
      "age": age,
      "college": college,
    });
  }

  Future updateOneData(String label, var value) async {
    return await userCollection.document(uid).setData({
        label: value
    });
  }

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


  List<User> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return User(
        uid: doc.documentID,
        name: doc.data['name'] ?? '',
        college: doc.data['college'] ?? '',
        age: doc.data['age'] ?? 0,
        gender: doc.data['gender'] ?? '',
      );
    }).where((test)=> test.uid != uid).toList();
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot){
    return User(
      uid: uid,
      name: snapshot.data['name'],
      age: snapshot.data['age'],
      gender: snapshot.data['gender'],
      college: snapshot.data['college'],
      firstLogin: snapshot.data['firstLogin'],
    );
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

  //get user stream of all users
  Stream<List<User>> get users{
    return userCollection.snapshots() //turn a QuerySnapshot into List<User>
        .map(_userListFromSnapshot);
  }

  //get specific user
  Stream<User> get user{
    return  userCollection.document(uid).snapshots() //documentSnapshot -> UserData
        .map(_userDataFromSnapshot);
  }

  Stream<List<Message>> get messages{
    return chatRoomCollection.document(chatRoomId)
        .collection('messages').orderBy('time').snapshots()
        .map(_messageListFromSnapshot);
  }

  Stream<QuerySnapshot> get chatRooms{
    return chatRoomCollection.orderBy('lastModify', descending: true).snapshots();
  }



  Future checkLiked(String targetId) async{
    QuerySnapshot qs = await likeCollection.where('from', isEqualTo: uid)
        .where('to', isEqualTo: targetId).getDocuments();
    int len = qs.documents.length;
    return len == 1 ? true : false;
  }

  Stream<QuerySnapshot> get likes{
    return likeCollection.where("from", isEqualTo: uid).snapshots();
  }

  Stream<QuerySnapshot> get dislikes{
    return dislikeCollection.where("from", isEqualTo: uid).snapshots();
  }





}
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csci3100/models/message.dart';
import 'package:csci3100/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService{
  final CollectionReference userCollection = Firestore.instance.collection('user');
  final CollectionReference chatRoomCollection = Firestore.instance.collection('chatRoom');
  final CollectionReference likeCollection = Firestore.instance.collection('likes');
  final CollectionReference dislikeCollection = Firestore.instance.collection('dislikes');
  final CollectionReference imagesCollection = Firestore.instance.collection('images');

  final String uid;
  final String chatRoomId;
  final String targetId;
  final bool isUser1;
  DatabaseService({this.uid, this.chatRoomId, this.targetId, this.isUser1});


  Future checkLiked(String targetId) async{
    QuerySnapshot qs = await likeCollection.where('from', isEqualTo: uid)
        .where('to', isEqualTo: targetId).getDocuments();
    int len = qs.documents.length;
    return len == 1 ? true : false;
  }


  Future getImageUrl(int no) async {
    StorageReference ref = FirebaseStorage.instance.ref().child('/images/$uid/$no.png');
    Uri uri = Uri.parse(await ref.getDownloadURL() as String);
    return uri;
    /*userCollection.document(uid).collection('imageUrl').document().setData({
      'no': no,
      'url': uri
    });*/
  }








}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/userdb.dart';
import 'dart:core';

import 'package:firebase_storage/firebase_storage.dart';

//this class handle all method related to image collection
class ImageDB{
  final CollectionReference imagesCollection = Firestore.instance.collection('images');
  final uid;

  //constructor
  ImageDB({this.uid});

  //save image url to database
  Future saveImageUrl(String now, bool isFirst) async {
    StorageReference ref = FirebaseStorage.instance.ref().child('/images/$uid/$now.png');
    String uri = await ref.getDownloadURL() as String;
    imagesCollection.document(uid).collection('imageUrl').add({
      'time': now,
      'url': uri
    });
    if (isFirst){
      UserDB(uid: uid).updateOneData('icon', uri);
    }
  }

  //update any existing data
  Future updateOneData(String label, var value) async {
    return await imagesCollection.document(uid).updateData({
      label: value
    });
  }

  //set the unexisted data field with data
  Future setOneData(String label, var value) async {
    return await imagesCollection.document(uid).setData({
      label: value
    });
  }



  //delete data field
  Future deleteData() async {
    return await imagesCollection.document(uid).collection('imageUrl').getDocuments().then((onValue){
      for (DocumentSnapshot doc in onValue.documents) {
        doc.reference.delete();
      }
    });
  }

  //create a stream to the image list of specific user
  Stream<List<MyUrl>> get images{
    return imagesCollection.document(uid).collection('imageUrl').orderBy('time').snapshots()
        .map(_urlListFromSnapshot);
  }

  //create a stream to all user's image url
  Stream<QuerySnapshot> get imageList{
    return imagesCollection.orderBy('lastLogin').snapshots();
  }

  //turn all firebase url data into MyUrl type
  List<MyUrl> _urlListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return MyUrl(
          time: doc.data['time'] ?? '',
          url: doc.data['url'] ?? ''
      );
    }).toList();
  }


}
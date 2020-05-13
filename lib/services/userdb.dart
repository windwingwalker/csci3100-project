import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csci3100/models/user.dart';

//this class define all method related to user collection
class UserDB{
  final CollectionReference userCollection = Firestore.instance.collection('user');
  final CollectionReference imagesCollection = Firestore.instance.collection('images');

  final uid;
  final User currentUser;

  //constructor
  UserDB({this.uid, this.currentUser});

  //set the info when user first login
  Future setFirst() async {
    return await userCollection.document(uid).setData({
      "firstLogin": true,
      "isBanned": false,
    });
  }

  //set the basic info of user when he first login
  Future setSelfInfo(String name, double age, String gender, String college) async {
    return await userCollection.document(uid).updateData({
      "name": name,
      "age": age,
      "gender": gender,
      "college": college,
      "imageNum": 0,
      "isActivate": true
    });
  }

  //set the basic info of user's target when he first login
  Future setTargetInfo(String gender, double start, double end) async {
    return await userCollection.document(uid).updateData({
      "targetGender": gender,
      "targetAgeStart": start,
      "targetAgeEnd": end,
    });
  }

  //set the description field when user first login
  Future setDesc(String desc) async {
    return await userCollection.document(uid).updateData({
      "description": desc,
    });
  }


  //update user existing data
  Future updateUserData(String name, double age, String college, String gender, String desc) async {
    return await userCollection.document(uid).updateData({
      "name": name,
      "gender": gender,
      "age": age,
      "college": college,
      "description": desc
    });
  }

  //delete user data
  Future deleteData() async {
    return await userCollection.document(uid).delete();
  }

  //
  Future updateOneData(String label, var value) async {
    return await userCollection.document(uid).updateData({
      label: value
    });
  }

  //get user stream of all users
  Stream<List<User>> get unfilteredUsers{
    return userCollection.orderBy('lastLogin').snapshots() //turn a QuerySnapshot into List<User>
        .map(_userListFromSnapshot);
  }

  Stream<List<User>> get filteredUsers{
    return userCollection.orderBy('age').orderBy('lastLogin')
        .where('gender', isEqualTo: currentUser.targetGender)
        .where('age', isLessThanOrEqualTo: currentUser.targetAgeEnd)
        .where('age', isGreaterThanOrEqualTo: currentUser.targetAgeStart)
        .where('isActivate', isEqualTo: true)
        .snapshots() //turn a QuerySnapshot into List<User>
        .map(_userListFromSnapshot);
  }

  //get specific user
  Stream<User> get user{
    return  userCollection.document(uid).snapshots() //documentSnapshot -> UserData
        .map(_userDataFromSnapshot);
  }

  List<User> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return User(
        uid: doc.documentID,
        name: doc.data['name'] ?? '',
        college: doc.data['college'] ?? '',
        age: doc.data['age'] ?? 0,
        gender: doc.data['gender'] ?? '',
        firstLogin: doc.data['firstLogin'],
        imageNum: doc.data['imageNum'],
        url: doc.data['icon'],
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
      imageNum: snapshot.data['imageNum'],
      url: snapshot.data['icon'],
      desc: snapshot.data['description'],
      targetAgeStart: snapshot.data['targetAgeStart'],
      targetAgeEnd: snapshot.data['targetAgeEnd'],
      targetGender: snapshot.data['targetGender'],
      isActivate: snapshot.data['isActivate'],
      isBanned: snapshot.data['isBanned']
    );
  }

}
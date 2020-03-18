import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csci3100/models/user.dart';

class DatabaseService{
  final CollectionReference userCollection = Firestore.instance.collection('user');
  final String uid;
  DatabaseService({this.uid});

  Future updateUserData(String name, String college, int age) async {
    return await userCollection.document(uid).setData({
      'name': name,
      //'gender': gender,
      'college': college,
      'age': age,
    });
  }

  List<User> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return User(
        name: doc.data['name'] ?? '',
        college: doc.data['college'] ?? '',
        age: doc.data['age'] ?? 0,
      );
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      age: snapshot.data['age'],
      college: snapshot.data['college'],
    );
  }

  //get user stream of all users
  Stream<List<User>> get users{
    return userCollection.snapshots() //turn a QuerySnapshot into List<User>
        .map(_userListFromSnapshot);
  }

  //get specific user
  Stream<UserData> get userData{
    return userCollection.document(uid).snapshots() //documentSnapshot -> UserData
        .map(_userDataFromSnapshot);
  }
}
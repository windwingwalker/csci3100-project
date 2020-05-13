import 'package:cloud_firestore/cloud_firestore.dart';

//this class define all method related to support collection
class SupportDB{
  final CollectionReference supportCollection = Firestore.instance.collection('support');
  final String email;
  final String content;

  SupportDB({this.email, this.content});

  //set a request record
  Future setRequest() async {
    return await supportCollection.document().setData({
      "type": "Request",
      "email": email,
      "content": content
    });
  }

  //set a report record
  Future setReport(String from, String to) async {
    return await supportCollection.document().setData({
      "type": "Report",
      "from": from,
      "to": to,
      "content": content
    });
  }
}
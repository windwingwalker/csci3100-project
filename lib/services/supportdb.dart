import 'package:cloud_firestore/cloud_firestore.dart';

class SupportDB{
  final CollectionReference supportCollection = Firestore.instance.collection('support');
  final String email;
  final String content;

  SupportDB({this.email, this.content});

  Future setRequest() async {
    return await supportCollection.document().setData({
      "type": "Request",
      "email": email,
      "content": content
    });
  }

  Future setReport(String from, String to) async {
    return await supportCollection.document().setData({
      "type": "Report",
      "from": from,
      "to": to,
      "content": content
    });
  }
}
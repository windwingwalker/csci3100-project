import 'package:flutter/material.dart';
import 'package:csci3100/models/user.dart';

class ChatRoomTile extends StatelessWidget {
  final User user;
  ChatRoomTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[300],
          ),
          title: Text(user.name),
          subtitle: Text('Hi this guy is ${user.name}'),
        ),
      ),
    );
  }
}

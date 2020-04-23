import 'package:csci3100/models/message.dart';
import 'package:csci3100/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageTile extends StatelessWidget {
  final Message message;

  const MessageTile({this.message});

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserId>(context);
    return Container(
      child: Column(
        crossAxisAlignment: userId.uid == message.from ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            color: userId.uid == message.from ? Colors.teal : Colors.red,
            borderRadius: BorderRadius.circular(10.0),
            elevation: 6.0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Text(
                message.text,
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:csci3100/services/database.dart';
import 'package:csci3100/services/messagedb.dart';
import 'package:csci3100/views/chat/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:csci3100/models/user.dart';
import 'package:provider/provider.dart';

class ChatRoomTile extends StatelessWidget {
  final User target;
  final String room;
  final bool isUser1;
  final int unread;
  ChatRoomTile({this.target, this.room, this.isUser1, this.unread});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: () {
          MessageDB(chatRoomId: room).resetUnread(isUser1);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ChatRoom(room: room, target: target, isUser1: isUser1,)),
          );
        },
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.brown[300],
              child: ClipOval(
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.network(target.url, fit: BoxFit.fill),
                ),
              ),
            ),
            title: Text(target.name),
            subtitle: Text(unread.toString()),
          ),
        ),
      ),
    );
  }
}

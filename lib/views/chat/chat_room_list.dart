import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/database.dart';
import 'package:csci3100/views/user_tile.dart';
import 'package:csci3100/views/chat/chat_room_tile.dart';

class ChatRoomList extends StatefulWidget {
  @override
  _ChatRoomListState createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<User>>(context) ?? [];
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        return ChatRoomTile(user: users[index]);
      },
    );
  }
}

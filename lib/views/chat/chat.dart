import 'package:csci3100/views/chat/chat_room_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csci3100/services/database.dart';
import 'package:csci3100/models/user.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
      value: DatabaseService().users,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Chat room'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
        ),
        body: ChatRoomList(),
      ),
    );
  }
}

import 'package:csci3100/services/userdb.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/views/chat/chat_room_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csci3100/models/user.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
      value: UserDB().unfilteredUsers,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
          flexibleSpace: Container(
            decoration: appBarDecoration,
          ),
        ),
        body: Container(
          decoration: bodyDecoration,
          child: ChatRoomList()
        ),
      ),
    );
  }
}

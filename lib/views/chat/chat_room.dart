import 'package:csci3100/models/message.dart';
import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/database.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'message_tile.dart';

class ChatRoom extends StatefulWidget {
  final String room;
  final String targetName;
  final String targetId;
  final bool isUser1;
  ChatRoom({this.room, this.targetName, this.targetId, this.isUser1});
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<List<Message>>(
      stream: DatabaseService(chatRoomId: widget.room).messages,
      builder: (context, snapshot){
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        List<Message> messages = snapshot.data;
        Future<void> sent() async {
          if (messageController.text.length > 0) {
            await DatabaseService(chatRoomId: widget.room, isUser1: widget.isUser1, uid: user.uid)
                .sendMessage(messageController.text, DateTime.now().toIso8601String().toString());
            messageController.clear();
            scrollController.animateTo(
              scrollController.position.maxScrollExtent,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 300),
            );
          }
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.targetName),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: ListView.separated(
                    itemCount: messages.length,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return MessageTile(message: messages[index]);
                    },
                    separatorBuilder: (context, index) => Divider(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: messageController,
                          decoration: textInputDecoration.copyWith(hintText: "Enter a message"),
                        ),
                      ),
                      MySubmitButton("Sent", sent),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}


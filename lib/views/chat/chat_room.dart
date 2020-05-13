import 'package:csci3100/models/message.dart';
import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/messagedb.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'message_tile.dart';

class ChatRoom extends StatefulWidget {
  final String room;
  final User target;
  final bool isUser1;
  ChatRoom({this.room, this.isUser1, this.target});
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserId>(context);
    return StreamBuilder<List<Message>>(
      stream: MessageDB(chatRoomId: widget.room).messages,
      builder: (context, snapshot){
        if (!snapshot.hasData)
          return Center(
            child: CircularProgressIndicator(),
          );
        List<Message> messages = snapshot.data;
        Future<void> sent() async {
          if (messageController.text.length > 0) {
            await MessageDB(chatRoomId: widget.room, isUser1: widget.isUser1, uid: userId.uid)
                .sendMessage(messageController.text, DateTime.now().toUtc().toIso8601String().toString());
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
            title: Text(widget.target.name),
            actions: <Widget>[
              FlatButton.icon(
                onPressed: () => Navigator.of(context).pushNamed('/report', arguments: widget.target),
                icon: Icon(Icons.flag),
                label: Text("Report user")
              ),
            ],
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
                      MessageDB(chatRoomId: widget.room).resetUnread(widget.isUser1);
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


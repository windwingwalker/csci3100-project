import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csci3100/services/messagedb.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csci3100/models/user.dart';
import 'package:csci3100/views/chat/chat_room_tile.dart';

class ChatRoomList extends StatefulWidget {
  @override
  _ChatRoomListState createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<User>>(context) ?? [];
    final user = Provider.of<User>(context);

    return StreamBuilder<QuerySnapshot>(
      stream: MessageDB().chatRooms,
      builder: (context, snapshot){
        if (snapshot.hasData){
          List<DocumentSnapshot> docs = snapshot.data.documents;
          //return a list of chat room tile
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index){
              if (docs[index]['user1'] == user.uid){ //if you are user1 in message
                for (var i = 0; i < users.length; i++){
                  if (users[i].uid == docs[index]['user2']){
                    return ChatRoomTile(target: users[i], room: docs[index].documentID, isUser1: true, unread: docs[index]['user1Unread'],);
                  }
                }return Container();
              }else if (docs[index]['user2'] == user.uid){ //if you are user2 in message
                for (var i = 0; i < users.length; i++){
                  if (users[i].uid == docs[index]['user1']){
                    return ChatRoomTile(target: users[i], room: docs[index].documentID, isUser1: false, unread: docs[index]['user2Unread'],);
                  }
                }return Container();
              }else{
                return Container();
              }
            },
          );

        }else{
          return Container();
        }
      },
    );
  }
}

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:csci3100/models/user.dart';
import 'user_tile.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<User>>(context) ?? [];
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return UserTile(user: users[index]);
        },
    );
  }
}

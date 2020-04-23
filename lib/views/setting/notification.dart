import 'package:csci3100/models/user.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool showNewMatch = true;
  bool showNewMessage = true;

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserId>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        flexibleSpace: Container(
          decoration: appBarDecoration,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        decoration: bodyDecoration,
        child: Column(
          children: <Widget>[
            MySwitch(name: "New Matches", value: showNewMatch ,changeFunc: (bool val)=> setState(()=> showNewMatch = val)),
            MySwitch(name: "New Messages", value: showNewMessage ,changeFunc: (bool val)=> setState(()=> showNewMessage = val)),
          ],
        ),
      ),
    );
  }
}

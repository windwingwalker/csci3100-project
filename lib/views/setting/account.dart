import 'package:csci3100/models/user.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool isDeactivate = false;

  bool showEmail = true;
  bool showBirthday = true;


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        flexibleSpace: Container(
          decoration: appBarDecoration,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        decoration: bodyDecoration,
        child: Column(
          children: <Widget>[
            MySwitch(name: "Deactivate Account", value: isDeactivate ,changeFunc: (bool val)=> setState(()=>isDeactivate = val)),
            MySwitch(name: "Show Email", value: showEmail ,changeFunc: (bool val)=> setState(()=> showEmail = val)),
            MySwitch(name: "Show Birthday", value: showBirthday ,changeFunc: (bool val)=> setState(()=> showBirthday = val)),
          ],
        ),
      ),
    );
  }
}

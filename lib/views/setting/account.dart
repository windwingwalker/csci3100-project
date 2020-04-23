import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/auth.dart';
import 'package:csci3100/services/userdb.dart';
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

  bool showEmail = false;
  bool showBirthday = true;
  bool deleteAc = false;
  bool isBlur = false;

  TextEditingController _textFieldController = TextEditingController();
  final AuthService _auth = AuthService();

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure to leave us?'),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Type 'Delete CUagain' to confirm delete"),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('CONFIRM'),
                onPressed: () {
                  if (_textFieldController.text == "Delete CUagain"){
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/login');
                    _auth.deleteAccount();
                  }else{
                    _textFieldController.clear();
                  }
                },
              )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserId>(context);
    UserDB db = UserDB(uid: userId.uid);
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
            MySwitch(name: "Deactivate Account", value: isDeactivate ,changeFunc: (bool val){
              setState(()=>isDeactivate = val);
              db.updateOneData('isActivate', !val);
            }),
            MySwitch(name: "Blur Mode", value: isBlur ,changeFunc: (bool val){
              setState(()=> isBlur = val);
              db.updateOneData('isBlur', val);
            }),
            MySwitch(name: "Delete Account", value: deleteAc ,changeFunc: (bool val){
              if (val = true){
                _displayDialog(context);
              }
            }),

          ],
        ),
      ),
    );
  }
}

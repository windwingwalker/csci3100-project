import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/userdb.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:csci3100/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Target extends StatefulWidget {
  @override
  _TargetState createState() => _TargetState();
}

class _TargetState extends State<Target> {
  final _formKey = GlobalKey<FormState>();
  final List<String> genders = ['Male', "Female"];

  String gender;
  var range = RangeValues(18, 30);
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserId>(context);
    if (userId != null){
      void submit() async {
        if (_formKey.currentState.validate()) {
          setState(() => loading = true);
          await UserDB(uid: userId.uid).setTargetInfo(gender, range.start, range.end);
          Navigator.of(context).pushReplacementNamed('/desc');
        }
      }

      return loading ? Loading() : Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: Container(
            decoration: bodyDecoration,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              children: <Widget>[
                MyFirstLoginTitle(text: "Who are you looking for?", size: 50),
                MyFirstLoginTitle(text: "Please provide some criteriea of your target", size: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0,),
                      MyDropdownButtonFormField(value: gender, type: "Gender", mylist: genders, changeFunc: (String val) => setState(()=> gender = val)),
                      Text("Age", style: TextStyle(color: Colors.lightGreenAccent)),
                      MyRangeSlider(range: range, changeFunc: (RangeValues val) => setState(()=> range = val)),
                      MySubmitButton("Next", submit),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }else{
      return Loading();
    }

  }
}

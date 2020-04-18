import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/auth.dart';
import 'package:csci3100/services/database.dart';
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
  String gender = 'Male';
  var range = RangeValues(18, 30);
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    void submit() async {
      if (_formKey.currentState.validate()) {
        setState(() => loading = true);
        await DatabaseService(uid: user.uid).setTargetInfo(gender, range.start, range.end);
        Navigator.of(context).pushReplacementNamed('/desc');
      }
    }

    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              "Who are you looking for?",
              style: TextStyle(fontSize: 50),
            ),
          ),
          Container(
            child: Text(
              "Please provide some criteriea of your target",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                Text("Gender"),
                MyDropdownButtonFormField(value: gender,mylist: genders, changeFunc: (String val) => setState(()=> gender = val)),
                Text("Age"),
                MyRangeSlider(range: range, changeFunc: (RangeValues val) => setState(()=> range = val)),
                MySubmitButton("Next", submit),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

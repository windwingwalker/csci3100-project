import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/userdb.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:csci3100/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Basic extends StatefulWidget {
  @override
  _BasicState createState() => _BasicState();
}

class _BasicState extends State<Basic> {
  final _formKey = GlobalKey<FormState>();
  final List<String> colleges = ['CC', 'NA', 'UC', 'SHAW', 'SHHO', 'WYS', 'MC', 'CW', 'WS'];
  final List<String> genders = ['Male', "Female"];

  bool loading = false;
  String name = '';
  double age = 18;
  String gender;
  String college;


  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserId>(context);
    if (userId != null){
      void submit() async {
        if (_formKey.currentState.validate()) {
          setState(() => loading = true);
          UserDB(uid: userId.uid).setSelfInfo(name, age, gender, college);
          Navigator.of(context).pushReplacementNamed('/target_info');
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
                MyFirstLoginTitle(text: "Welcome", size: 50),
                MyFirstLoginTitle(text: "It seems that you are the first time to use CUagain! It is a chance to know more about you!", size: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      MyTextFormField(type: "Name",changeFunc: (String val) => setState(()=> name = val)),
                      SizedBox(height: 20.0),
                      Text("Age", style: TextStyle(color: Colors.lightGreenAccent)),
                      MySlider(age: age,changeFunc: (double val) => setState(()=> age = val)),
                      SizedBox(height: 20.0),
                      MyDropdownButtonFormField(value: gender,type: "Gender", mylist: genders, changeFunc: (String val) => setState(()=> gender = val)),
                      SizedBox(height: 20.0),
                      MyDropdownButtonFormField(value: college,type: "College", mylist: colleges, changeFunc: (String val) => setState(()=> college = val)),
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

import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/database.dart';
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
  String gender = 'Male';
  String college = 'CC';


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    void submit() async {
      if (_formKey.currentState.validate()) {
        setState(() => loading = true);
        await DatabaseService(uid: user.uid).setSelfInfo(name, age, gender, college);
        Navigator.of(context).pushReplacementNamed('/target_info');
        setState(() => loading = false);
      }
    }
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
                "Welcome",
              style: TextStyle(fontSize: 50),
            ),
          ),
          Container(
            child: Text(
                "It seems that you are the first time to use CUagain! It is a chance to know more about you!",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                Text("Name"),
                MyTextFormField(type: "Name",changeFunc: (String val) => setState(()=> name = val)),
                Text("Age"),
                MySlider(age: age,changeFunc: (double val) => setState(()=> age = val)),
                Text("Gender"),
                MyDropdownButtonFormField(value: gender,mylist: genders, changeFunc: (String val) => setState(()=> gender = val)),
                Text("College"),
                MyDropdownButtonFormField(value: college,mylist: colleges, changeFunc: (String val) => setState(()=> college = val)),
                MySubmitButton("Next", submit),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

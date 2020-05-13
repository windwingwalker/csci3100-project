import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/userdb.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:csci3100/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Discover extends StatefulWidget {
  final User user;
  const Discover({this.user});
  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  final _formKey = GlobalKey<FormState>();
  final List<String> genders = ['Male', "Female"];
  String gender;

  var range;
  bool loading = false;
  @override
  Widget build(BuildContext context) {

    final userId = Provider.of<UserId>(context);
    void submit() async {
      setState(() {
        loading = true;
      });
      if (_formKey.currentState.validate()) {
        await UserDB(uid: userId.uid).setTargetInfo(gender, range.start, range.end);
        Navigator.of(context).pop();
      }
    }

    //set default value
    setState(() {
      if (gender == null){
        gender = widget.user.targetGender;
      }
      if (range == null){
        range = RangeValues(widget.user.targetAgeStart, widget.user.targetAgeEnd);
      }
    });

    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        title: Text("Discover Setting"),
        flexibleSpace: Container(
          decoration: appBarDecoration,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        decoration: bodyDecoration,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              Text("Gender", style: TextStyle(color: Colors.lightGreenAccent)),
              MyDropdownButtonFormField(value: gender, type: "Gender", mylist: genders, changeFunc: (String val) => setState(()=> gender = val)),
              SizedBox(height: 20.0,),
              Text("Age", style: TextStyle(color: Colors.lightGreenAccent)),
              MyRangeSlider(range: range, changeFunc: (RangeValues val) => setState(()=> range = val)),
              MySubmitButton("Save", submit),
            ],
          ),
        ),
      ),
    );
  }
}

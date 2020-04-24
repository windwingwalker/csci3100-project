import 'package:csci3100/services/supportdb.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:csci3100/shared/loading.dart';
import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String content;
  bool loading = false;
  void submit() async {
    setState(() {loading = true;});
    if (_formKey.currentState.validate()) {
      SupportDB(email: email, content: content).setRequest();
      Navigator.of(context).pop();
    }
    setState(() => loading = false);
  }
  @override
  Widget build(BuildContext context) {

    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Help & Support"),
        flexibleSpace: Container(
          decoration: appBarDecoration,
        ),
      ),
      body: Container(
        decoration: bodyDecoration,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  MyTextFormField(type: "Your contact email", changeFunc: (String val) => setState(()=> email = val)),
                  SizedBox(height: 20,),
                  MyTextFormField(type: "Your request", changeFunc: (String val) => setState(()=> content = val)),
                  MySubmitButton("Submit", submit),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

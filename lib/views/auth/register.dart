import 'package:csci3100/services/auth.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:csci3100/shared/loading.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String email = '';
  String password = '';
  void submit() async {
    if (_formKey.currentState.validate()){
      setState(() => loading = true);
      dynamic result = await _auth.signUp(email, password);
      setState(() => loading = false);
      if (result == null){
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              content: Text("Email account has already been used"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }else {
        showDialog(
          context: context,
          builder: (BuildContext context){
            return AlertDialog(
              content: Text("We have already sent a verification email to you, please login after you verify the account"),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacementNamed('/login');
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Register'),
          flexibleSpace: Container(
            decoration: appBarDecoration,
          ),
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
                icon: Icon(Icons.person),
                label: Text('Login')
            ),
          ],
        ),
        body: Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            decoration: bodyDecoration,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 18.0),
                  MyTextFormField(type: "Email",changeFunc: (String val) => setState(()=> email = val)),
                  SizedBox(height: 18.0),
                  MyTextFormField(type: "Password",changeFunc: (String val) => setState(()=> password = val)),
                  SizedBox(height: 18.0),
                  TextFormField(
                    obscureText: true,
                    validator: (val) => val != password || val.isEmpty ? "Not match" : null,
                    cursorColor: Colors.lightGreenAccent,
                    style: TextStyle(color: Colors.orange),
                    decoration: textInputDecoration.copyWith(labelText: 'Confirm password'),
                  ),
                  SizedBox(height: 18.0),
                  MySubmitButton("Register", submit),
                ],
              ),
            )
        )
    );
  }
}

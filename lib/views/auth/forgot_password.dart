import 'package:csci3100/shared/inputs.dart';
import 'package:csci3100/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:csci3100/services/auth.dart';
import 'package:csci3100/shared/constants.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String message = '';

  void submit() async {
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      dynamic result = await _auth.resetPassword(email);
      if (result == null){
        setState(() {
          message = 'Invalid email';
          loading = false;
        });
      }else {
        setState(() {
          message = "Email sent";
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Reset Password'),
        flexibleSpace: Container(
          decoration: appBarDecoration,
        ),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () => Navigator.of(context).pushReplacementNamed('/login'),
            icon: Icon(Icons.person),
            label: Text('Login'),
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
                SizedBox(height: 20.0),
                MyTextFormField(type: "Email",changeFunc: (String val) => setState(()=> email = val)),
                SizedBox(height: 20.0),
                MySubmitButton("Send reset email", submit),
              ]
            ),
          )
        )
    );
  }
}

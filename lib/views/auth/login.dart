import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/auth.dart';
import 'package:csci3100/services/database.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:csci3100/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  void submit() async {
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      dynamic result = await _auth.signIn(email, password);
      if (result == null){
        setState(() {
          error = 'COULD NOT SIGN IN WITH THOSE CREDENTIALS';
          loading = false;
        });
      }else{
        DatabaseService(uid: result.uid).user.listen((onData) {
          if (onData.firstLogin == true){
            Navigator.of(context).pushReplacementNamed('/self_info');
          }else{
            Navigator.of(context).pushReplacementNamed('/bottombar');
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Log in'),
          flexibleSpace: Container(
            decoration: appBarDecoration,
          ),
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () => Navigator.of(context).pushReplacementNamed('/register'),
              icon: Icon(Icons.person),
              label: Text('Register'),
            ),
            FlatButton.icon(
              icon: Icon(Icons.lock_open),
              label: Text('Forgot password'),
              onPressed: () => Navigator.of(context).pushReplacementNamed('/forgot_password'),
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
                  MyTextFormField(type: "Password",changeFunc: (String val) => setState(()=> password = val)),
                  SizedBox(height: 20.0),
                  MySubmitButton("Log in", submit),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.amber, fontSize: 14.0),
                  )
                ],
              ),
            )
        )
    );
  }
}


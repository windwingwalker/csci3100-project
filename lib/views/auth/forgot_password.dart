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

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Reset Password'),
        elevation: 0.0,
        backgroundColor: Colors.brown[400],
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
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Send reset email',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.resetPassword(email);
                      if (result == null){
                        setState(() {
                          message = 'Invalid';
                          loading = false;
                        });
                      }else {
                        setState(() {
                          message = "Email sent";
                          loading = false;
                        });
                      }
                    }
                  },
                ),
              ]
            ),
          )
        )
    );
  }
}

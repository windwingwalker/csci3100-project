import 'package:csci3100/services/auth.dart';
import 'package:csci3100/shared/constants.dart';
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
  String message = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text('Register'),
          elevation: 0.0,
          backgroundColor: Colors.brown[400],
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
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Password must be at least 6 characters' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.signUp(email, password);
                        if (result == null){
                          setState(() {
                            message = 'Please enter valid email';
                            loading = false;
                          });
                        } else {
                          setState(() {
                            message = "We have already sent a verification email to you, please login after you verify the account";
                            loading = false;
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(height: 12.0,),
                  Text(
                    message,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ),
            )

        )
    );
  }
}

import 'package:csci3100/views/register.dart';
import 'package:flutter/material.dart';
import 'package:csci3100/views/login.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;

  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return Login(toggleView: toggleView); //pass toggleView() of this class into Login class
    }else{
      return Register(toggleView: toggleView);
    }
  }
}

import 'package:csci3100/models/user.dart';
import 'package:csci3100/routing/authenticate.dart';
import 'package:csci3100/views/login.dart';
import 'package:flutter/material.dart';
import 'package:csci3100/views/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}

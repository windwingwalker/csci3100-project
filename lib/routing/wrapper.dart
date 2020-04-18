import 'package:csci3100/models/user.dart';
import 'package:csci3100/routing/bottombar.dart';
import 'package:csci3100/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null){
      return Login();
    }else{
      return BottomBar();
    }
  }
}

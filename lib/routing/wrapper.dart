import 'package:csci3100/models/user.dart';
import 'package:csci3100/routing/bottombar.dart';
import 'package:csci3100/views/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //this is a wrapper to route user to different pages depends on its authentication
    final userId = Provider.of<UserId>(context);
    return userId == null ? Login() : BottomBar();
  }
}

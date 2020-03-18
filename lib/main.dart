import 'package:csci3100/routing/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:csci3100/views/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';
import 'services/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value( //state the return type
      value: AuthService().user, //return value
      child: MaterialApp( //every thing in this widget is based on the value of streamprovide
        home: Wrapper(),
      )
    );
  }
}


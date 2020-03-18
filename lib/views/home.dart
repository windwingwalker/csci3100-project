import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csci3100/routing/authenticate.dart';
import 'package:csci3100/views/settings_form.dart';
import 'package:csci3100/views/user_list.dart';
import 'package:flutter/material.dart';
import 'package:csci3100/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:csci3100/services/database.dart';
import 'package:csci3100/models/user.dart';

class Home extends StatelessWidget {
   final AuthService _auth = AuthService();

   @override
   Widget build(BuildContext context) {
     void _showSettingsPanel() {
       showModalBottomSheet(context: context, builder: (context) {
         return Container(
           padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
           child: SettingForm(),
         );
       });
     }
     return StreamProvider<List<User>>.value(
       value: DatabaseService().users,
       child: Scaffold(
         backgroundColor: Colors.brown[50],
         appBar: AppBar(
           title: Text('Tinder'),
           backgroundColor: Colors.brown[400],
           elevation: 0.0,
           actions: <Widget>[
             FlatButton.icon(
                 onPressed: () async {
                   await  _auth.signOut();
                 },
                 icon: Icon(Icons.person),
                 label: Text('logout')),
             FlatButton.icon(
                 onPressed: () => _showSettingsPanel(),
                 icon: Icon(Icons.settings),
                 label: Text('setting'),
             ),
             FlatButton.icon(
                 onPressed: () => Navigator.of(context).pushNamed('/chat'),
                 icon: Icon(Icons.chat),
                 label: Text('chat')
             ),
           ],
         ),
         body: UserList(),
       ),
     );
   }
 }

import 'package:csci3100/services/auth.dart';
import 'package:csci3100/services/database.dart';
import 'package:flutter/material.dart';
import 'package:csci3100/models/user.dart';
import 'package:provider/provider.dart';

class System extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final DatabaseService _db = DatabaseService(uid: user.uid);
    print(user.uid);
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('System Setting'),
        backgroundColor: Colors.brown[200],
        elevation: 0.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () => _auth.signOut(),
                  icon: Icon(Icons.exit_to_app),
                  label: Text("Logout"))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () => _db.inactivate(),
                  icon: Icon(Icons.lock),
                  label: Text("Inactivate account"))
            ],
          ),
        ],
      ),
    );




  }
}

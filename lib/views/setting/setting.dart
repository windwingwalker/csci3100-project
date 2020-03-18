import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csci3100/models/user.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      backgroundColor: Colors.brown[200],
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/image_upload'),
                child: CircleAvatar(
                  backgroundColor: Colors.red[400],
                  radius: 125.0,
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () => Navigator.of(context).pushNamed('/profile'),
                  icon: Icon(Icons.edit),
                  label: Text("Edit")
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () => Navigator.of(context).pushNamed('/profile'),
                  icon: Icon(Icons.settings_applications),
                  label: Text("System setting"),
              )
            ],
          )
        ],
      ),


    );
  }
}

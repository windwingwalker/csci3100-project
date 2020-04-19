import 'package:csci3100/services/auth.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csci3100/models/user.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    final AuthService _auth = AuthService();

    void accountFunc(){
      Navigator.of(context).pushNamed('/account');
    }
    void notificationFunc(){
      Navigator.of(context).pushNamed('/notification');
    }
    void discoverFunc(){
      Navigator.of(context).pushNamed('/discover');
    }
    void helpFunc(){
      Navigator.of(context).pushNamed('/help');
    }
    void logoutFunc(){
      _auth.signOut();
      Navigator.of(context).pushReplacementNamed('/login');
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        flexibleSpace: Container(
          decoration: appBarDecoration,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        decoration: bodyDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MySettingButton("Account", Icons.account_box, accountFunc, 150),
                MySettingButton("Notification", Icons.notifications_active, notificationFunc, 150),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MySettingButton("Discover Setting", Icons.search, discoverFunc, 150),
                MySettingButton("Help & Support", Icons.help_outline, helpFunc, 150),
              ],
            ),
            MySettingButton("Log out", Icons.exit_to_app, logoutFunc, 340),
          ],
        ),
      ),
    );
  }
}

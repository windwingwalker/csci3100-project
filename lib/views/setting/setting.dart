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
    void reportFunc(){
      Navigator.of(context).pushNamed('/report');
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
        title: Text("Setting"),
        flexibleSpace: Container(
          decoration: appBarDecoration,
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        decoration: bodyDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            /*Row(
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
            ),*/
            MySettingButton("Account", Icons.account_box, accountFunc),
            MySettingButton("Notification", Icons.notifications_active, notificationFunc),
            MySettingButton("Discover setting", Icons.search, discoverFunc),
            MySettingButton("Report", Icons.report_problem, reportFunc),
            MySettingButton("Help & Support", Icons.help_outline, helpFunc),
            MySettingButton("Log out", Icons.exit_to_app, logoutFunc),
          ],
        ),
      ),
    );
  }
}

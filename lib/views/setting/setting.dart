import 'package:csci3100/services/auth.dart';
import 'package:csci3100/services/userdb.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:csci3100/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csci3100/models/user.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserId>(context);
    final AuthService _auth = AuthService();

    void accountFunc(){
      Navigator.of(context).pushNamed('/account');
    }
    void notificationFunc(){
      Navigator.of(context).pushNamed('/notification');
    }

    void helpFunc(){
      Navigator.of(context).pushNamed('/help');
    }
    void logoutFunc(){
      _auth.signOut();
      Navigator.of(context).pushReplacementNamed('/');
    }

    return StreamBuilder<User>(
      stream: UserDB(uid: userId.uid).user,
      builder: (context, snapshot) {
        if (snapshot.hasData){
          User user = snapshot.data;
          void discoverFunc(){
            Navigator.of(context).pushNamed('/discover', arguments: user);
          }
          return Scaffold(
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              title: Text("Settings"),
              flexibleSpace: Container(
                decoration: appBarDecoration,
              ),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              decoration: bodyDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        MySettingButton("Account", Icons.account_box, accountFunc),
                        SizedBox(width: 30,),
                        MySettingButton("Notification", Icons.notifications_active, notificationFunc),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MySettingButton("Discover Setting", Icons.search, discoverFunc),
                        SizedBox(width: 30,),
                        MySettingButton("Help & Support", Icons.help_outline, helpFunc),
                      ],
                    ),
                  ),
                  SizedBox(height: 30,),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        MySettingButton("Log out", Icons.exit_to_app, logoutFunc)
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }else{
          return Loading();
        }
      }
    );
  }
}

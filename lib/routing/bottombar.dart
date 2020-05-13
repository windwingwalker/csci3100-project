import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/userdb.dart';
import 'package:csci3100/views/chat/chat.dart';
import 'package:csci3100/views/home/home.dart';
import 'package:csci3100/views/profile/profile.dart';
import 'package:csci3100/views/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedPage = 1;
  final _pageOptions = [
    Profile(),
    Home(),
    Chat(),
    Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserId>(context);
    return StreamProvider<User>.value(
      value: UserDB(uid: userId.uid).user,
      child: Scaffold(
        body: _pageOptions[_selectedPage],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPage,
          //change the top page if any of the button clicked
          onTap: (int index){
            setState(() {
              _selectedPage = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          //these four buttons will remain the whole running time
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text('Chat'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text('Setting'),
            ),
          ],
          selectedItemColor: Colors.amber[800],
        ),
      ),
    );
  }
}

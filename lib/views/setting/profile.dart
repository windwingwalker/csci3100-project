import 'package:flutter/material.dart';
import 'package:csci3100/models/user.dart';
import 'package:provider/provider.dart';
import 'package:csci3100/services/database.dart';
import 'package:csci3100/shared/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final _formKey = GlobalKey<FormState>();
  final List<String> colleges = ['CC', 'NA', 'UC', 'SHAW'];

  String _currentName;
  String _currentCollege;
  int _currentAge;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot){
        if (snapshot.hasData){
          UserData userData = snapshot.data;
          return Scaffold(
            backgroundColor: Colors.brown[600],
            appBar: AppBar(
              title: Text("Profile"),
              backgroundColor: Colors.brown[900],
            ),
            body: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text("Name"),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) => val.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20.0,),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    items: colleges.map((college){
                      return DropdownMenuItem(
                        value: college,
                        child: Text('$college colleges'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentCollege = val),
                    value: _currentCollege ?? userData.college,
                  ),
                  Slider(
                    value: (_currentAge ?? 100).toDouble(),
                    activeColor: Colors.blue[_currentAge ?? 100],
                    inactiveColor: Colors.blue[_currentAge ?? 100],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) => setState(() => _currentAge = val.round()),
                  ),
                  RaisedButton(
                    color: Colors.pink[400],
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentName ?? userData.name,
                            _currentCollege ?? userData.college,
                            _currentAge ?? userData.age
                        );
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        }else{
          return null;
        }
      },
    );
  }
}

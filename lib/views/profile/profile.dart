import 'package:csci3100/shared/inputs.dart';
import 'package:csci3100/shared/loading.dart';
import 'package:firebase_storage/firebase_storage.dart';
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


  //torageReference imageRef = storage.getReferenceFromUrl(fullUrl)

  final _formKey = GlobalKey<FormState>();
  final List<String> colleges = ['CC', 'NA', 'UC', 'SHAW', 'SHHO', 'WYS', 'MC', 'CW', 'WS'];
  final List<String> genders = ['Male', "Female"];

  String _currentName;
  String _currentCollege;
  double _currentAge = 21;
  String _currentGender;
  String _currentDescription;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //print(user.name);
    return StreamBuilder<User>(
      stream: DatabaseService(uid: user.uid).user,
      builder: (context, snapshot){
        if (snapshot.hasData){
          User user = snapshot.data;
          void submit() async {
            if(_formKey.currentState.validate()){

              await DatabaseService(uid: user.uid).updateUserData(
                _currentName ?? user.name,
                _currentAge ?? user.age,
                _currentCollege ?? user.college,
                _currentGender ?? user.gender,
              );
              Navigator.of(context).pushReplacementNamed('/bottombar');
            }
          }
          return FutureBuilder(
            future: DatabaseService(uid: user.uid).getImageUrl(),
            builder: (context, snapshot){
              if (snapshot.hasData){
                Uri url = snapshot.data;
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Profile"),
                    flexibleSpace: Container(
                      decoration: appBarDecoration,
                    ),
                  ),
                  body: Container(
                    padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
                    decoration: bodyDecoration,
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => Navigator.of(context).pushReplacementNamed('/image_upload'),
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundColor: Colors.red,
                                  child: ClipOval(
                                    child: SizedBox(
                                      width: 180,
                                      height: 180,
                                      child: Image.network("$url",
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text("Name"),
                              ),
                              Expanded(
                                flex: 5,
                                child: MyTextFormField(initValue: user.name, type: "Name", changeFunc: (String val) => setState(()=> _currentName = val)),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text("Age"),
                              ),
                              Expanded(
                                flex: 5,
                                child: MySlider(age: _currentAge, changeFunc: (double val) => setState(()=> _currentAge = val)),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text("Gender"),
                              ),
                              Expanded(
                                flex: 5,
                                child: MyDropdownButtonFormField(value: _currentGender ?? user.gender ,mylist: genders, changeFunc: (String val) => setState(()=> _currentGender = val)),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Text("College"),
                              ),
                              Expanded(
                                flex: 5,
                                child: MyDropdownButtonFormField(value: _currentCollege ?? user.college ,mylist: colleges, changeFunc: (String val) => setState(()=> _currentCollege = val)),
                              ),
                            ],
                          ),
                          MySubmitButton("Save", submit),
                        ],
                      ),
                    ),
                  ),
                );
              }else{
                return Loading();
              }
            },
          );
        }else{
          return Scaffold(
            body: Text("Something wrong"),
          );
        }
        /*
                  Slider(
                    value: (_currentAge ?? 100).toDouble(),
                    activeColor: Colors.blue[_currentAge ?? 100],
                    inactiveColor: Colors.blue[_currentAge ?? 100],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) => setState(() => _currentAge = val.round()),
                  ),
            ),*/
      },
    );
  }
}

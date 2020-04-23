import 'package:csci3100/services/imagedb.dart';
import 'package:csci3100/services/userdb.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:csci3100/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:csci3100/models/user.dart';
import 'package:provider/provider.dart';
import 'package:csci3100/shared/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final List<String> colleges = ['CC', 'NA', 'UC', 'SHAW', 'SHHO', 'WYS', 'MC', 'CW', 'WS'];
  final List<String> genders = ['Male', "Female"];

  String _currentName;
  String _currentCollege;
  double _currentAge;
  String _currentGender;
  String _currentDescription;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if (user != null){
      void submit() async {
        setState(() {
          loading = true;
        });
        if(_formKey.currentState.validate()){
          await UserDB(uid: user.uid).updateUserData(
            _currentName ?? user.name,
            _currentAge ?? user.age,
            _currentCollege ?? user.college,
            _currentGender ?? user.gender,
            _currentDescription ?? user.desc
          );
          Navigator.of(context).pushReplacementNamed('/bottombar');
        }
        setState(() {
          loading = false;
        });
      }
      return StreamBuilder<List<MyUrl>>(
        stream: ImageDB(uid: user.uid).images,
        builder: (context, snapshot) {
          if (snapshot.hasData){
            List<MyUrl> images = snapshot.data;
            return loading ? Loading() : Scaffold(
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
                            onTap: () => Navigator.of(context).pushNamed('/gallery'),
                            child: CircleAvatar(
                              radius: 80,
                              backgroundColor: Colors.amberAccent,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 180,
                                  height: 180,
                                  child: Image.network(images[0].url, fit: BoxFit.fill),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20,),
                      MyTextFormField(initValue: user.name, type: "Name", changeFunc: (String val) => setState(()=> _currentName = val)),
                      SizedBox(height: 20,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text("Age", style: TextStyle(color: Colors.lightGreenAccent),),
                          ),
                          Expanded(
                            flex: 5,
                            child: MySlider(age: _currentAge ?? user.age, changeFunc: (double val) => setState(()=> _currentAge = val)),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text("Gender", style: TextStyle(color: Colors.lightGreenAccent)),
                          ),
                          Expanded(
                            flex: 5,
                            child: MyDropdownButtonFormField(value: _currentGender ?? user.gender , type: "Gender", mylist: genders, changeFunc: (String val) => setState(()=> _currentGender = val)),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Text("College", style: TextStyle(color: Colors.lightGreenAccent)),
                          ),
                          Expanded(
                            flex: 5,
                            child: MyDropdownButtonFormField(value: _currentCollege ?? user.college , type: "College", mylist: colleges, changeFunc: (String val) => setState(()=> _currentCollege = val)),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      MyTextFormField(initValue: user.desc, type: "Description of you", changeFunc: (String val) => setState(()=> _currentDescription = val)),
                      MySubmitButton("Save", submit),
                    ],
                  ),
                ),
              ),
            );
          }else{
            return Loading();
          }
        }
      );
    }else{
      return Loading();
    }
  }
}

import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/userdb.dart';
import 'package:csci3100/shared/constants.dart';
import 'package:csci3100/shared/inputs.dart';
import 'package:csci3100/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Description extends StatefulWidget {
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  String description = '';

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserId>(context);
    if (userId != null){
      void submit() async {
        if (_formKey.currentState.validate()) {
          setState(() => loading = true);
          await UserDB(uid: userId.uid).setDesc(description);
          Navigator.of(context).pushReplacementNamed('/image_upload_first');
        }
      }
      return loading ? Loading() : Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: Container(
            decoration: bodyDecoration,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              children: <Widget>[
                MyFirstLoginTitle(text: "Do you want others know more about you?", size: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      MyTextFormField(type: "Description of you", changeFunc: (String val) => setState(()=> description = val)),
                      MySubmitButton("Next", submit),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }else{
      return Loading();
    }
  }
}

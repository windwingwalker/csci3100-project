import 'package:csci3100/models/user.dart';
import 'package:csci3100/services/database.dart';
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
    final user = Provider.of<User>(context);

    void submit() async {
      if (_formKey.currentState.validate()) {
        setState(() => loading = true);
        await DatabaseService(uid: user.uid).setDesc(description);
        Navigator.of(context).pushReplacementNamed('/bottombar');
      }
    }
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
            child: Text(
              "Do you want others know more about you?",
              style: TextStyle(fontSize: 50),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                MyTextFormField(type: "Description of you", changeFunc: (String val) => setState(()=> description = val)),
                MySubmitButton("Finish", submit),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
